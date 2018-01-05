class CreateUrls < ActiveRecord::Migration[5.1]
  def change
    create_table :urls do |t|
      t.string :original_url, null: false
      t.string :short_url, index: true, null: false
      t.string :sanitized_url, index: true, null: false

      t.timestamps
    end
  end
end
