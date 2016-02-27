class DeviseCreateDukes < ActiveRecord::Migration
  def change
    create_table(:dukes) do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      t.string :phonenumber
      t.string :firstname
      t.string :lastname
      t.string :mailingaddress
      t.string :mailingcity
      t.string :mailingstate
      t.string :mailingcountry
      t.string :mailingzipcode
      t.boolean :is_mailingsameasphysicaladdress, default: true
      t.string :physicaladdress
      t.string :physicalcity
      t.string :physicalstate
      t.string :physicalcountry
      t.string :physicalzipcode
      t.datetime :birthday
      t.integer :rating, default: 100
      t.integer :numberofquests, default: 0
      t.integer :numberofnotes, default: 0
      t.boolean :partiallyregistered, default: false
      t.boolean :fullyregistered, default: false
      t.string :customertoken


      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.inet     :current_sign_in_ip
      t.inet     :last_sign_in_ip

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at


      t.timestamps
    end

    add_index :dukes, :email,                unique: true
    add_index :dukes, :reset_password_token, unique: true
    add_index :dukes, :confirmation_token,   unique: true
    # add_index :dukes, :unlock_token,         unique: true
  end
end
