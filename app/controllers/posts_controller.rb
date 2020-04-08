# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :signed_in, only: %i[new create]

  def index
    @posts = Post.paginate(page: params[:page],
                           per_page: 5).order('created_at DESC')
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:success] = 'Rumour posted !'
      redirect_to posts_path
    else
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :user_id)
  end

  def signed_in
    unless logged_in?
      flash[:danger] = 'Please Sign in.'
      redirect_to login_path
    end
end
end
