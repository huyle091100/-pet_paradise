module ApplicationHelper
  def check_admin_layout
    current_page?(controller: 'products') || current_page?(controller: 'users') || 
    current_page?('/products/new') || current_page?('/users/new') || current_page?('/bills') || 
    current_page?(controller: 'products', action: :edit)
  end
end
