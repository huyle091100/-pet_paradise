module ApplicationHelper
  def check_admin_layout
    request.original_url.include?("products") || request.original_url.include?("users") || request.original_url.include?("bills") || request.original_url.include?("rooms") || request.original_url.include?("manage_bookings")
  end

  def weight_text weight
    case weight
    when "less_than_5"
      "Less than 5kg"
    when "five_to_ten"
      "5 - 10kg"
    when "ten_to_fifteen"
      "10 - 15kg"
    when "fifteen_to_twenty"
      "15 - 20kg"
    when "greater_than_20"
      "Greater than 20kg"
    end
  end
end
