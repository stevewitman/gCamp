class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :commment
      t.belongs_to :user
      t.belongs_to :task
      t.timestamps
    end
  end
end
