# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :authenticate_user!
  def create
    @like = Like.new(like_param)
    @like.save
    @status = params[:status]
    if @status == 'show'
      redirect_to post_path(params[:id])
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    current_user.likes.each { |like| like.destroy if like.post_id == params[:id].to_i }
    if @status == 'show'
      redirect_to post_path(params[:id])
    else
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def like_param
    params.permit(:post_id, :user_id)
  end
end
