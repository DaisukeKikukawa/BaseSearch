class ChangeEmailNullConstraintInTeams < ActiveRecord::Migration[7.1]
  def change
    change_column_null :teams, :email, true
  end
end
