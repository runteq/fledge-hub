class AddStudyStartedNullFalseOnToUsers < ActiveRecord::Migration[6.1]
  def change
    change_column_null :users, :study_started_on, false
  end
end
