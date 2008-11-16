require File.dirname(__FILE__) + '/spec_helper'

def password
  "HG3pJX7N0z7sY12"
end
def path
  "/e97e5d84cd8d39ca6"
end

describe Writeboard do
  before(:all) do
    Writeboard.create({
      :name => "Feature1",
      :password => password,
      :path => path
    })
  end
  
  describe ".create(hash)" do
    it "should add the writeboard with name, password and address to the @@writeboards collection" do
      Writeboard.writeboards.detect {|wb| wb.name == "Feature1"}.password.should eql(password)
    end
    it "should yield the logged in writeboard if block given" do
      Writeboard.create({
        :name => "Feature1",
        :password => password,
        :path => path
      }) do |wb|
        wb.password.should eql(password)
      end
    end
  end
  
  describe "writeboards.find(hash)" do
    describe "| returns the first writeboard that matches all conditions defined by name value pairs in the arg hash | " do
      describe "@@writeboards empty" do
        it "should return nil if @@writeboards is empty" do
          Writeboard.writeboards.find(:name => "value").should be_nil
        end
        it "should return nil if hash contains several names and collection is empty" do
          Writeboard.writeboards.find(:nonexistant => "nonexistant", :anotherone => "value").should be_nil
        end
      end
      describe "@@writeboards contains a writeboard" do
        before(:each) do
          @writeboard = Writeboard.new({:name => "value", :password => "123456", :path => "/path"})
        end
        
        it "should return existing remote_feature with name value" do
          Writeboard.writeboards.find(:name => "value").should eql(@writeboard)
        end
        
        it "should return nil if hash contains value that doesn't match remote_feature" do
          Writeboard.writeboards.find(:name => "nonexistant").should be_nil
        end
        
        it "should return nil if hash contains name pair that doesn't match remote_feature" do
          Writeboard.writeboards.find(:nonexistant => "nonexistant").should be_nil
        end
        
        it "should return nil if hash contains several names that doesn't match remote_feature" do
          Writeboard.writeboards.find(:nonexistant => "nonexistant", :anotherone => "value").should be_nil
        end
      end
    end
  end
  
  describe ".find(hash)" do
    it "should yield the writeboard, identified by hash and logged in" do
      Writeboard.find :name => "Feature1" do |wb|
        wb.password.should eql(password)
        wb.path.should eql(path)
      end
    end
  end
  
  describe "#get" do
    it "should get the writeboard" do
      Writeboard.find :name => "Feature1" do |wb|
        wb.get.password.should eql(password)
        wb.get.path.should eql(path)
      end
    end
    it "should set the writeboards title" do
      Writeboard.find :name => "Feature1" do |wb|
        wb.get.title.should eql("first writeboard")
      end
    end
    it "should set the writeboards body" do
      Writeboard.find :name => "Feature1" do |wb|
        wb.get.body.should eql('Feature: FeatureTitle\n In order to gain profits')
      end
    end
  end
  
  describe "post_without_revision" do
    it "should post to the writeboard and make no new revision" do
      Writeboard.find :name => "Feature1" do |wb|
        wb.post_without_revision(:body => 'Feature: FeatureTitle\n In order to gain profits')
        wb.get.body.should eql('Feature: FeatureTitle\n In order to gain profits')
      end
    end
    
    it "should get what it posts" do
      Writeboard.find :name => "Feature1" do |wb|
        string = 'Feature: FeatureTitle\n In order to gain profits'
        wb.post_without_revision(:body => string)
        wb.get.body.should eql(string)
      end
    end
  end
end


