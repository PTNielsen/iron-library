class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :keywords
      t.boolean :available, :default => true
      t.string :campus

      t.timestamps null: false
    end
  end
end