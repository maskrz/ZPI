class CreateMessages < ActiveRecord::Migration
  def change
    drop_table :messages if self.table_exists?("messages")
    create_table :messages do |t|
      t.text :content
      t.boolean :is_read
      t.references :sender, :class_name => "User"
      t.references :reciver, :class_name => "User"
      t.timestamps
    end
  end
end
