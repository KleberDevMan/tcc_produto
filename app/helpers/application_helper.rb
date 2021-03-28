module ApplicationHelper
  def bool_s(bool)
    bool ? raw('<span class="text-info">Sim</span>') : raw('<span class="text-warning">Não</span>')
  end

  def title(page_title, col_xl_10 = false)
    @col_xl_10 = col_xl_10
    content_for(:title) { page_title }
  end

  def last_action
    Rails.application.routes.recognize_path(request.referrer)[:action]
  end
end
