class ProfileController < ApplicationController
    def index

    end

    def edit

    end

    def update
        user = User.find_by id: user_param[:id]
        if user 
            user.update user_param
            flash[:notice] = "Update profile successfully!"
        end
        redirect_to root_path
    end

    private

    def user_param
        params.permit :first_name, :last_name, :address, :phone_number, :id
    end
end