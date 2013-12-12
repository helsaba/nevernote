class UsersController < ApplicationController
  include UsersHelper

  skip_before_filter :require_logged_in,  only: [:new, :create]
  before_filter :require_logged_out, only: [:new, :create]

  def new
    render :new
  end

  def create
    user = User.new(params[:user])

    if user.save
      create_first_notebook!(user)
      login!(user)
      redirect_to user_url(user)
    else
      render json: user.errors.full_messages
    end
  end

  # TEMPORARY - Final app will not have a users/show route
  def show
    render :show
  end

end