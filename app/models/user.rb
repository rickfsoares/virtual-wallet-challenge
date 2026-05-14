class User < ApplicationRecord
  has_many :wallet_entries, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  def current_balance
    entries = wallet_entries
    credits = entries.where(entry_type: :credit).sum(:amount)
    debits = entries.where(entry_type: :debit).sum(:amount)
    credits - debits
  end
end
