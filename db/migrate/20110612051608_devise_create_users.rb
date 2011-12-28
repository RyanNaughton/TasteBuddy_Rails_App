class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :username, null: false
      t.string :first_name
      t.string :last_name
      t.string :postal_code, limit: 10
      t.string :country
      t.string :gender, limit: 1
      t.date :birthday
      t.string :roles

      t.database_authenticatable null: false
      t.recoverable
      t.rememberable
      t.trackable

      # t.encryptable
      # t.confirmable
      # t.lockable lock_strategy: :failed_attempts, unlock_strategy: :both
      t.token_authenticatable


      t.timestamps
    end

    add_index :users, :email,                unique: true
    add_index :users, :username,             unique: true
    add_index :users, :reset_password_token, unique: true
    # add_index :users, :confirmation_token,   unique: true
    # add_index :users, :unlock_token,         unique: true
    add_index :users, :authentication_token, :unique => true
  end
end
