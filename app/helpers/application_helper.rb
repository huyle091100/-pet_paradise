module ApplicationHelper
  def check_admin_layout
    request.original_url.include?("products") || request.original_url.include?("users") || request.original_url.include?("bills") || request.original_url.include?("rooms")
  end
end
