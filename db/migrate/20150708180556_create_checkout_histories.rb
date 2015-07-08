class CreateCheckoutHistories < ActiveRecord::Migration
  def change
    create_table :checkout_histories do |t|
      t.integer :user_id
      t.integer :book_id
      t.boolean :returned, :default => false
      t.datetime :due_date

      t.timestamps null: false
    end
  end
end
