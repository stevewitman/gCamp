class RenameCommentsColumn < ActiveRecord::Migration
  def change
    rename_column :comments, :commment, :content
  end
end
