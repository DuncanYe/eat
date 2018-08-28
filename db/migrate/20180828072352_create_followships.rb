class CreateFollowships < ActiveRecord::Migration[5.2]
  def change
    create_table :followships do |t|
      t.references :user, foreign_key: true
      t.integer :following_id

      t.timestamps
    end
  end
end
