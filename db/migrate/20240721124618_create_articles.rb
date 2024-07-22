class CreateArticles < ActiveRecord::Migration[7.1]
  def change
    create_table :articles do |t|
      t.string :title
      t.text :body
      t.string :status
      t.integer :created_by

      t.timestamps
    end
  end
end
