module ApplicationHelper
  def body_class(body_class)
    content_for(:body_class){body_class}
  end
  def page_title(page_title)
    content_for(:page_title){page_title}
  end
end
