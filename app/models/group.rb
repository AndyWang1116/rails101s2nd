class Group < ActiveRecord::Base # Group這class繼承Rails內建 ActiveRecord::Base的功能, 可讓我們透過Ruby語法操作資料庫 (sqlite3 , pg)
  #資料驗證: title欄位不能為空白
  validates :title, presence: {message: "此欄位不可以是空白!"}      # presence: true 也可以，會自動顯示 "can't be blank"

  has_many :posts, dependent: :destroy  # 建立與 post之間的資料庫關聯, 且當刪除group時所屬的posts也一併刪除
  has_many :group_users
  has_many :members, through: :group_users, source: :user

 # 建立與 user之前的資料庫關聯,在此 :owner等同於 :user,不管什麼名稱都會對應到user model
  belongs_to :owner, class_name: "User", foreign_key: :user_id

  def editable_by?(user)
    user && user == owner     # (user(存在/true)) && (user == owner)
  end
end
