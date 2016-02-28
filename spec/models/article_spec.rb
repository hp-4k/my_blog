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
  it { is_expected.to have_many(:comments).dependent(:destroy) }
  
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
  
  describe "#preview" do
    
    it "returns the first 100 characters of the article's content" do
      article = build(:article, content: 'a' * 150)
      expect(article.preview).to eq ('a' * 100 + '...')
    end
    
  end
  
  describe "default scope" do
    
    it "returns articles sorted from youngest to oldest" do
      @article1 = create(:article)
      @article2 = create(:other_article)
      @article3 = create(:article3)
      expect(Article.all[0]).to eq @article3
      expect(Article.all[2]).to eq @article1
    end
    
  end
  
end
