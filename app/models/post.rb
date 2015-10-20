class Post < ActiveRecord::Base
  belongs_to :group, counter_cache: :posts_count #使用Rails model內建功能counter_cache, 在這裡設定好已加入group裡的對應欄位名稱 posts_count
  validates :content, presence: {message: "欄位不可為空白！"}

  belongs_to :author, class_name: "User", foreign_key: :user_id  # :author等同於 :user, 連接到user的model

  scope :recent, -> {order("updated_at DESC")}    # 在model內將常用到的功能.order(updated_at DESC) 用scope 定義成 :recent 來呼叫
                                                  # 有點像是將別人的名字 "自訂暱稱"一樣 , 如此即可在controller使用 .recent

  def editable_by?(user)
    user && user == author
  end

end
