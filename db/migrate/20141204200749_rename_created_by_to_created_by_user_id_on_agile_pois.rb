class RenameCreatedByToCreatedByUserIdOnAgilePois < ActiveRecord::Migration
  def change
    rename_column :agile_pois, :created_by, :created_by_user_id
  end
end
