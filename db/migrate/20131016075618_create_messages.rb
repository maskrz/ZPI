class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :content
      t.datetime :sent_at
      t.boolean :is_read

      t.timestamps
    end
  end
end
