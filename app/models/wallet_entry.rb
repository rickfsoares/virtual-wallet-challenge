class WalletEntry < ApplicationRecord
  belongs_to :user
  enum :entry_type, { credit: 0, debit: 1 }

  validates :amount, presence: true, numericality: { greater_than: 0, less_than: 100_000_000 }
  validates :entry_type, presence: true
  validates :description, presence: true, length: { maximum: 255 }
end
