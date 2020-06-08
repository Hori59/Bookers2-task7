class ChangeDatatypePrefectureCodeOfUsers < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :prefecture_code, :string
  end
end
