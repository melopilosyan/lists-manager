class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :name
      t.integer :status, default: Order::Status::ORDERED
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :orders, :users, on_delete: :cascade
  end
end
