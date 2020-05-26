class CreateVotes < ActiveRecord::Migration[6.0]
  def change
    create_table :votes do |t|
      t.bigint :work_id
      t.bigint :user_id

      t.timestamps
    end
    add_index :votes, :work_id
    add_index :votes, :user_id
  end
end
