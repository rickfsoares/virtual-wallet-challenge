class CreateWalletEntries < ActiveRecord::Migration[8.0]
  def change
    create_table :wallet_entries do |t|
      t.references :user, null: false, foreign_key: true
      t.decimal :amount, precision: 10, scale: 2, default: 0.0
      t.string :description
      t.integer :entry_type, null: false

      t.timestamps
    end
  end
end
