class CreatePings < ActiveRecord::Migration[5.2]
  def change
    create_table :pings do |t|
      t.belongs_to :council, foreign_key: true, index: false
      t.boolean :is_up, null: false
      t.datetime :created_at, null: false
    end

    add_index :pings, [:council_id, :created_at, :is_up]
  end
end
