class Article < ActiveRecord::Base
  belongs_to :user
  
  validates :title, presence: true, uniqueness: true
  validates :content, presence: true
  
  def html_content
    renderer = Redcarpet::Render::HTML.new(filter_html: true)
    markdown = Redcarpet::Markdown.new(renderer, autolink: true, tables: true)
    markdown.render(content)
  end
  
  def preview
    Nokogiri::HTML(html_content).text[0...100] + '...'
  end
  
end
