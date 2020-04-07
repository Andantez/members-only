# frozen_string_literal: true

class SessionsController < ApplicationController
  def index; end

  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      flash[:success] = 'Welcome to Members Only'
      redirect_to root_path
    else
      flash.now[:danger] = 'Invalid email or password'
      render :new
    end
  end

  def destroy
    sign_out if logged_in?
    redirect_to root_path
  end
end
