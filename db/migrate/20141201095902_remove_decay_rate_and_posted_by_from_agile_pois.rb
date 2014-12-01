class RemoveDecayRateAndPostedByFromAgilePois < ActiveRecord::Migration
  def change
    remove_column :agile_pois, :decay_rate, :float
    remove_column :agile_pois, :posted_by, :string
  end
end
