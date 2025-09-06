class AddUserToTrips < ActiveRecord::Migration[8.0]
  def change
    # Add the column as nullable first
    add_reference :trips, :user, null: true, foreign_key: true
    
    # Assign existing trips to the first user (if any exists)
    if User.exists? && Trip.exists?
      first_user = User.first
      Trip.where(user_id: nil).update_all(user_id: first_user.id)
    end
    
    # Now make the column not nullable
    change_column_null :trips, :user_id, false
  end
end
