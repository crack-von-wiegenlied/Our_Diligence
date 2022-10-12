class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.integer :category_id
      t.string :title
      t.text :body
      t.decimal :work_time, precision: 12, scale: 2
      t.datetime :start_time

      t.timestamps
    end
  end
end
