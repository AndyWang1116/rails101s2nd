class AddUserIdToGroup < ActiveRecord::Migration
  def change
    add_column :groups, :user_id , :integer # terminal 需先執行 rails g migration add_user_id_to_group,新增完此行後執行rake db:migrate
  end
end
