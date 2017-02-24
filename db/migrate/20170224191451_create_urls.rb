class CreateUrls < ActiveRecord::Migration[5.0]
  def change
    create_table :urls do |t|
      t.text :long
      t.string :short
      t.string :custom

      t.timestamps
    end
    add_index :urls, :long, unique: true
    add_index :urls, :short, unique: true
    add_index :urls, :custom, unique: true
  end
end
