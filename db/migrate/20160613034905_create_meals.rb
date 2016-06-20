class CreateMeals < ActiveRecord::Migration
  def change
    create_table :meals do |t|
      t.string :name
      t.references :user, index: true
      t.references :order, index: true

      t.timestamps null: false
    end
    add_foreign_key :meals, :users, on_delete: :cascade
    add_foreign_key :meals, :orders, on_delete: :cascade

  end
end
