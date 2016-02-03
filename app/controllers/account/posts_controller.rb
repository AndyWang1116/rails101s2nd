class Account::PostsController < ApplicationController

  before_action :authenticate_user!

  def index
  #  @posts = current_user.posts.order("updated_at DESC")     # .order("updated_at DESC") 讓文章倒序排列(DESC) 最新 - 最舊
     @posts = current_user.posts.recent                      # 已在models/post.rb 使用scope將上面功能改叫作 .recent
  end

end
