class CreateAgilePois < ActiveRecord::Migration
  def change
    create_table :agile_pois do |t|
      t.string :title
      t.text :description
      t.integer :created_by
      t.string :posted_by
      t.float :decay_rate
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
