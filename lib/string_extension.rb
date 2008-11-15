String.module_eval do
  def compact
    self.gsub(%r(([ \t\f\r])+), " ").gsub(%r(\n+),"\n").gsub(%r(^\s+), "").gsub(%r(\s+$),"")
  end
  
  def cut_runner_output
    self.split(%r(### RUNNER OUTPUT ###)).first.chomp
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
end