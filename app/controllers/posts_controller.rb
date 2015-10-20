class PostsController < ApplicationController
  before_action :authenticate_user! # 要求登入,需先安裝gem devise並執行rails g devise:install ,posts只有5個actions,不需另外only:
  before_action :find_group    # 使用before_action先各個指定的action之前先執行 private內定義的find_group function
                               # 可在 :find_group後用 only: [:edit, :update]或 except: [:destroy] 以進行指定
                               # after_action  -- 執行完成action後的動作

  before_action :member_required, only: [:new, :create]  # 在底下private定義member_required,內容為對!current_user使用is_member_of?(已在user.rb定義)
  def new
    @post = @group.posts.new
  end

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def create
    @post = @group.posts.build(post_params)
    @post.author = current_user

    if @post.save
      redirect_to group_path(@group), notice: "新增文章成功！"
    else
      render :new
    end

  end

  def update
    @post = current_user.posts.find(params[:id])

    if @post.update(post_params)
      redirect_to group_path(@group), notice: "文章修改成功！"
    else
      render :edit
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])

    @post.destroy
    redirect_to group_path(@group), alert: "文章已刪除"
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end

  def find_group
    @group = Group.find(params[:group_id])
  end

  def member_required
    if !current_user.is_member_of?(@group)
      flash[:warning] = "你不是這個討論板的成員，無法發言"
      redirect_to group_path(@group)
    end
  end


end
