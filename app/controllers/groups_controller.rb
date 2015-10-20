class GroupsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy] # 要求登入,需先安裝gem devise並執行rails g devise:install

  # controller骨幹 : index, show, new, edit, create, update, detroy , 其中作者可 edit create update destroy
  def index
    # flash[:warning] = "下午到了! 該睡午覺了!" -- 測試notice_message這個helper的功能是否正常使用
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
    @posts = @group.posts
  end

  def new
    @group = Group.new # 將@group設定成一個新物件, 格式與規則與app/models/group.rb裡的設定
  end

  def edit
    @group = current_user.groups.find(params[:id])   # 登入的使用者(current_user)所擁有的"group資料(.groups)"來找某筆資料(.find(params[:id])"
  end

  def create
    @group = current_user.groups.new(group_params)

    if @group.save
      current_user.join!(@group)  # 讓使用者新增文章成功的同時自動成為group的ㄧ員
      redirect_to groups_path, notice: "新增討論版成功!"
    else
      render :new
    end
  end

  def update
    @group = current_user.groups.find(params[:id])

    if @group.update(group_params)
      redirect_to groups_path, notice: "修改討論版成功!"
    else
      render :edit
    end
  end

  def destroy
    @group = current_user.groups.find(params[:id])
    @group.destroy
    redirect_to groups_path, alert: "討論板已刪除"
  end

  def join
    @group = Group.find(params[:id])

    if !current_user.is_member_of?(@group)
      current_user.join!(@group)
      flash[:notice] = "加入本討論板成功！"
    else
      flash[:warning] = "你已經是本討論板成員了！"
    end

    redirect_to group_path(@group)
  end

  def quit
    @group = Group.find(params[:id])

    if current_user.is_member_of?(@group)
      current_user.quit!(@group)
      flash[:alert] = "已退出本討論板！"
    else
      flash[:warning] = "你不是本討論板成員，怎麼退出XD"
    end

    redirect_to group_path(@group)
  end

  private

  def group_params
    params.require(:group).permit(:title, :description)
  end
end

