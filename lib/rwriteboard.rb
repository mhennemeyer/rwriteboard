require 'rubygems'
require 'net/http'
require File.dirname(__FILE__) + "/string_extension.rb"

class Writeboard
  
  attr_accessor :password, 
                :path, 
                :session, 
                :cookie, 
                :http, 
                :name, 
                :header,
                :title,
                :body
  
  @@writeboards ||= []
  
  def @@writeboards.find(hash)
    memo = self
    hash.each do |k,v|
      memo = [memo.detect {|wb| !wb.nil? && wb.respond_to?(k.to_sym) && wb.send(k.to_sym) == v}]
    end
    memo.first
  end
  
  def initialize(hash)
    self.password = hash[:password]
    self.path     = hash[:path]
    self.name     = hash[:name]
    @@writeboards << self
    self
  end
  
  def get
    response_body = self.http.get(self.path, self.cookie).body
    self.title    = response_body.scan(%r{<div class="writeboardtitle">(.*?)</div>}m).to_s.strip_tags
    self.body     = response_body.scan(%r{<div class="writeboardbody">(.*?)</div>}m).to_s.strip_tags
    self
  end
  
  def logged_in
   Net::HTTP.start('123.writeboard.com') do |http|
      login_path     = self.path + "/login"
      self.header    = "password=#{self.password}"
      login_response = http.post(login_path, self.header)
      cookie         = {'Cookie' => login_response.response['Set-Cookie']}
      self.http      = http
      self.cookie    = cookie
      self.session   = cookie['Cookie'][1]
      yield self
    end
  end
  
  def post_without_revision(hash={})
    raise "There is no connection" unless self.http
    set_attributes_from_hash(hash)
    self.get unless self.title && self.body
    postdata = "minor_edit=1" + "&" +
    "commit=Save over the current version" + "&" +
    "version[body]=#{self.body.gsub(%r(\\n), "<br />")}" + "&" +
    "version[title]=#{self.title}"
    self.http.post(self.path + "/v/create", postdata, self.cookie)
  end
  
  def set_attributes_from_hash(hash)
    hash.each {|k,v| self.send(k.to_s.concat("=").to_sym, v)}
  end
  
  def self.create(hash)
    password = hash[:password]
    path = hash[:path] || hash[:id] || hash[:address] || ""
    path = "/" + path unless path =~ /^\//
    name = hash[:name] || self.count + 1
    wb = self.new(:password => password, :path => path, :name => name)
    if block_given?
      wb.logged_in do |_wb|
        yield _wb
      end
    end
    wb
  end
  
  def self.find(hash)
    writeboard = self.writeboards.find(hash)
    writeboard.logged_in do |wb|
      yield wb
    end
  end
  
  def self.count
    @@writeboards.size
  end
  
  def self.writeboards
    @@writeboards
  end
end