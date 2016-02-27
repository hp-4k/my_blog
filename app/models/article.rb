class Article < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged
  
  belongs_to :user
  
  validates :title, presence: true, uniqueness: true
  validates :content, presence: true
  
  default_scope { order(created_at: :desc) }
  
  def html_content
    renderer = Redcarpet::Render::HTML.new(filter_html: true)
    markdown = Redcarpet::Markdown.new(renderer, autolink: true, tables: true)
    markdown.render(content).html_safe
  end
  
  def preview
    Nokogiri::HTML(html_content).text[0...100] + '...'
  end
  
end
