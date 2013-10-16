class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :content
      t.boolean :is_read
      t.references :sender
      t.references :reciver
      t.timestamps
    end
  end
end
