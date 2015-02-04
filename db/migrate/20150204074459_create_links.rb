class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :url
      t.integer :visits
      t.string :local_slug

      t.timestamps
    end
  end
end
