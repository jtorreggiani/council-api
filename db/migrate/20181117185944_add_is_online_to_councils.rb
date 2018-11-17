class AddIsOnlineToCouncils < ActiveRecord::Migration[5.2]
  def change
    add_column :councils, :is_online, :boolean, null: false, default: false
  end
end
