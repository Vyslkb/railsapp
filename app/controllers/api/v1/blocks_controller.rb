class Api::V1::BlocksController < ApplicationController

	def create
		@user = User.find_by(id: params[:id])
		if @user.following?(current_user)
			@user.unfollow!(current_user)
		end
		current_user.block!(@user)
		render json: {status: "blocked"}
	end

	def destroy
		@user = User.find_by(id: params[:id])
		current_user.unblock!(@user)
		render json: {status: "unblocked"}
	end

	def blocks
		@user = current_user
		@users = @user.blocking.paginate(page: params[:page], per_page: 15)
		render 'lists/users'
	end

end