module ApplicationHelper
  def bool_s(bool)
    bool ? raw('<span class="text-info">Sim</span>') : raw('<span class="text-warning">Não</span>')
  end
end
