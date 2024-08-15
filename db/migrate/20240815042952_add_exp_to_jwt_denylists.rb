class AddExpToJwtDenylists < ActiveRecord::Migration[6.1]
  def change
    add_column :jwt_denylists, :exp, :datetime
  end
end
