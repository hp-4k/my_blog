require 'rails_helper'

RSpec.describe Article, type: :model do

  subject { FactoryGirl.build(:article) }

  # title validations
  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_uniqueness_of :title }
  
  # content validations
  it { is_expected.to validate_presence_of :content }
  
  # associations
  it { is_expected.to belong_to :user }
  
  describe "#html_content" do
    
    it "returns the article's content as html" do
      markdown_content = <<ENDSTRING
# Header
1. First item
2. Second item

Some text, [a link](http://www.google.com), and some *emphasized* text.
ENDSTRING
      html_content = <<ENDSTRING
<h1>Header</h1>

<ol>
<li>First item</li>
<li>Second item</li>
</ol>

<p>Some text, <a href="http://www.google.com">a link</a>, and some <em>emphasized</em> text.</p>
ENDSTRING
      article = build(:article, content: markdown_content)
      expect(article.html_content).to eq html_content
    end
    
  end
  
end
