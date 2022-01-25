class AddStudyStartedOnToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :study_started_on, :date, after: :email
  end
end
