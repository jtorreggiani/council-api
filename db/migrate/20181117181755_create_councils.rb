class CreateCouncils < ActiveRecord::Migration[5.2]
  def change
    create_table :councils do |t|
      t.text :gss, null: false
      t.text :name, null: false
      t.text :url
      t.text :snac
      t.text :ideal_postcodes_name

      t.timestamps
    end

    add_index :councils, :gss, unique: true
    add_index :councils, :name, unique: true
  end
end
