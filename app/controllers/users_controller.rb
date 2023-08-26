class UsersController < ApplicationController
  load_and_authorize_resource
  def index
    @users = User.where.not(id: current_user.id)
  end
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
        user.add_role params[:role]&.downcase&.to_sym
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
        user.add_role ["admin", "staff"].include?(row_values.last&.downcase&.to_sym) ? row_values.last&.downcase&.to_sym : "user"
        user.send_reset_password_instructions
      else
        next
      end
    end

    redirect_to users_path, notice: 'Excel file imported successfully.'
  rescue StandardError => e
    redirect_to users_path, alert: "Error importing Excel file: #{e.message}"
  end

  def destroy
    User.find_by(id: params[:id]).destroy
    flash[:notice] = "Delete user successfully."
    # redirect_to "#{request.referer}##{params[:id]}"
    respond_to do |format|
      format.js { render js: "window.location.href = '/users';" }
    end
  end
end
