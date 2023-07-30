module ApplicationHelper
  def check_admin_layout
    current_page?(controller: 'products') || current_page?(controller: 'users') || current_page?('/products/new') || current_page?('/users/new')
  end
end
