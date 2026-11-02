class RegistrationsController < ApplicationController

    allow_unauthenticated_access
    skip_after_action :verify_authorized

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)

        @user.role = :mechanic

        if @user.save
            start_new_session_for @user
            redirect_to root_path, notice: "Welcome to Wheelhouse Staff!"
        else
            render :new, status: :unprocessable_entity
        end
    end

    private

    def user_params
        params.require(:user).permit(:email_address, :password, :password_confirmation)
    end


end