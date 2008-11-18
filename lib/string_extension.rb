String.module_eval do
  def compact
    self.gsub(%r(([ \t\f\r])+), " ").gsub(%r(\n+),"\n").gsub(%r(^\s+), "").gsub(%r(\s+$),"")
  end
  
  def cut_runner_output(separator)
    (self.split(%r(#{separator})).first || "").chomp
  end
  
  def html_entity_quotes
    self.gsub(%r(&#8216;), "'").gsub(%r(&#8217;), "'").gsub(%r(&#8220;), '"').gsub(%r(&#8221;), '"')
  end
  
  def replace_newlines
    self.gsub(%r(<br />), '\n')
  end
  
  def remove_tags
    self.gsub(%r(<[^>]*>), "")
  end
  
  def strip_tags
    self.replace_newlines.remove_tags.compact
  end
  
  def unescape_newlines
    self.gsub(%r(\\n),"\n")
  end
end