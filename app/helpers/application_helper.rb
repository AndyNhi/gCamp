module ApplicationHelper

  def page_header(title, &block)
    content_for(:title, title)
    html = '<div class="page-header">'.html_safe
    html += '<div class="pull-right">'.html_safe
    html += capture do
      block.call
    end
    html += '</div>'.html_safe
    html += '<h1>'.html_safe
    html += title
    html += '</h1>'.html_safe
    html += '</div>'.html_safe
    html
  end

end
