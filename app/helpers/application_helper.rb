module ApplicationHelper

  def title(page_title)
    content_for(:title) { page_title }
  end

  class HTMLwithPygments < Redcarpet::Render::HTML
    include Redcarpet::Render::SmartyPants
    def block_code(code, language)
      Pygments.highlight(code, :lexer => language, :options => {:lineanchors => "line"})
    end
  end

  def markdown(text)
    renderer = HTMLwithPygments.new(prettify: true, hard_wrap: true, filter_html: true)
    options = {
      fenced_code_blocks: true,
      autolink: true,
      no_intra_emphasis: true,
      fenced_code_blocks: true,
      lax_spacing: true,
      lax_html_blocks: true,
      strikethrough: true,
      superscript: true,
      highlight: true,
      quote: true,
      footnotes: true,
      tables: true
    }
    Redcarpet::Markdown.new(renderer, options).render(text).html_safe
  end
end
