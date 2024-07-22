class AddDefaultValueToTags < ActiveRecord::Migration[7.1]
  def change
    change_column :articles, :tags, :string, array: true , default:[]
  end
end
