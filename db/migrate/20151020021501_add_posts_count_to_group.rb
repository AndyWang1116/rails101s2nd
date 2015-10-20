class AddPostsCountToGroup < ActiveRecord::Migration
  def change
    add_column :groups, :posts_count, :integer, default: 0   # 加上 default: 0  從0開始計算
  end
end
