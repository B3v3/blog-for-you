class AddSendEmailAcceptanceToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :send_email_acceptance, :boolean, :default => false
  end
end
