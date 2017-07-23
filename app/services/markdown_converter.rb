class MarkdownConverter
  def self.to_html(markdown_text)
    renderer = Redcarpet::Render::HTML.new(prettify: true, hard_wrap: true)
    markdown = Redcarpet::Markdown.new(renderer, extensions = {})
    markdown.render(markdown_text)
  end
end
