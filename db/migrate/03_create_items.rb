class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.references :user, index: true
      t.references :list, index: true

      t.timestamps null: false
    end
    add_foreign_key :items, :users, on_delete: :cascade
    add_foreign_key :items, :lists, on_delete: :cascade

  end
end
