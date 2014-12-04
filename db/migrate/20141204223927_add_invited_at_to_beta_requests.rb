class AddInvitedAtToBetaRequests < ActiveRecord::Migration
  def change
    add_column :beta_requests, :invited_at, :datetime
  end
end
