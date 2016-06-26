class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.string :name
      t.string :state, default: List::State::OPEN
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :lists, :users, on_delete: :cascade
  end
end
