class AddGeoportalFieldsToCouncils < ActiveRecord::Migration[5.2]
  def change
    add_column :councils, :lad18nm, :text
    add_column :councils, :fid, :integer
  end
end
