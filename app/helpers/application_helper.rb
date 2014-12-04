module ApplicationHelper
  def html_class(html_class)
    content_for(:html_class){html_class}
  end
  def body_class(body_class)
    content_for(:body_class){body_class}
  end
  def page_title(page_title)
    content_for(:page_title){page_title}
  end
  def caching()
    content_for(:manifest){" manifest=\"/application.manifest\" ".html_safe()}
  end
end
