require File.dirname(__FILE__) + '/spec_helper'

describe "String" do
  
  describe "#compact" do
    it "should replace any whitespace character except newline with a single space" do
      string = "  sdlkj      sdf  \t  sdfsdf \t      \t \t"
      string.compact.should eql("sdlkj sdf sdfsdf")
    end
    
    it "should replace multiple newlines with one newline" do
      string = " \n sdlkj sdf \t  \n \n   sdfsdf \n      \n \t"
      string.compact.should eql("sdlkj sdf\nsdfsdf")
    end
  end
  
  describe "#remove_tags" do
    it "should remove all tags from a string" do
      html = "<sdf>lksjdlkjasd<kjsadf/><sdf>"
      html.remove_tags.should eql("lksjdlkjasd")
    end
  end
  
  describe "#replace_newlines" do
    it "should replace all <br /> tags with '\\n'" do
      html = "Hello<br />"
      html.replace_newlines.should eql('Hello\n')
    end
  end
  
  describe "#cut_runner_output" do
    it "should cut away ### RUNNER OUTPUT ### and any subsequent characters" do
      html = '\nFeature: FeatureTitle\nIn order to gain profits\n
Scenario: On the new calculation Page\nGiven I am on the new calculation page\n
### RUNNER OUTPUT ###\nPending Scenarios:\n1) FeatureTitle\nIn order to gain profits (On the new calculation Page\n
Given I am on the new calculation page)\n'

      html.cut_runner_output.should eql('\nFeature: FeatureTitle\nIn order to gain profits\n
Scenario: On the new calculation Page\nGiven I am on the new calculation page\n')
    end
  end
  
  describe "#strip_tags" do
    it "should remove all tags except <br /> from a string" do
      html = <<-END
      <div class="standard_form">
            <h3> Sorry, this commit is taking too long to generate.  </h3>
            <p>
              View it locally:<br /> <code>$ git show 9a3a2ef</code>


            </p>
          </div>
      END
      string = "Sorry, this commit is taking too long to generate. " + 
               "View it locally:\n$ git show 9a3a2ef"
      string.strip_tags.should eql(string)
    end
  end
end

