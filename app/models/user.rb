class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :groups  # 設定user與group之間的資料庫關聯
  has_many :posts  # 設定userposts之間的資料庫關聯

  has_many :group_users
  has_many :participated_groups, through: :group_users, source: :group

  # 定義一個function is_member_of? 讓已存在的participated_groups使用include這個function來判斷現有的group是不是已經加入, 會回傳true or false
  def is_member_of?(group)
    participated_groups.include?(group)
  end

  def join!(group)
    participated_groups << group
  end

  def quit!(group)
    participated_groups.delete(group)
  end

end
