class ProfileController < ApplicationController
    def index

    end

    def edit

    end

    def update
        user = User.find_by id: user_param[:id]
        if user.update user_param
            flash[:notice] = "Update profile successfully!"
            redirect_to root_path
        else
            flash[:notice] = user.errors.messages.values.flatten.to_sentence
            redirect_to profile_index_path
        end
    end

    private

    def user_param
        params.permit :first_name, :last_name, :address, :phone_number, :id
    end
end