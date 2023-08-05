class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    params["repeater-group"]&.values&.map{|x| x[:email]}.each do |email|
      random_password = Devise.friendly_token.first(8)
      check_user = User.find_for_authentication(email: email)
      next if check_user
      user = User.new(email: email, password: random_password)
      user.skip_confirmation!
      if user.save
        user.add_role user_params[:role]&.downcase&.to_sym
        user.send_reset_password_instructions
      else
        next
      end
    end
    flash[:notice] = "Create user successfully!"
    redirect_to users_path
  end

  def import
    creek = Creek::Book.new(params[:file].tempfile.path, with_headers: true)
    sheet = creek.sheets[0]
    sheet.rows.each_with_index do |row, index|
      next if index == 0 # Skip the header row
      row_values = row.values
      check_user = User.find_for_authentication(email: row_values.first)
      next if check_user
      random_password = Devise.friendly_token.first(8)
      # Process the row data here
      user = User.new(email: row_values.first, password: random_password)
      user.skip_confirmation!
      if user.save
        user.add_role row_values.last&.downcase&.to_sym
        user.send_reset_password_instructions
      else
        next
      end
    end

    redirect_to users_path, notice: 'Excel file imported successfully.'
  rescue StandardError => e
    redirect_to users_path, alert: "Error importing Excel file: #{e.message}"
  end

  private

  def user_params
    params.require(:user).permit :role
  end
end
