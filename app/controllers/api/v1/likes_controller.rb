class Api::V1::LikesController < ApplicationController

before_action :authenticate_user!

def like
  @user = current_user
  @post = Post.find_by(id: params[:id])
  @user.like!(@post)
	render json: {
            success: true,
            info: "liked",
    }
end

def unlike
  @user = current_user
  @post = Post.find_by(id: params[:id])
  @user.unlike!(@post)
  	render json: {
            success: true,
            info: "unliked"
    }
end

def get_likes
  @post = Post.find_by(id: params[:id])
  @likes = @post.likes
  render json: {
    likes: @likes
  }
end

end