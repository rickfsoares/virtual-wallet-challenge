require "test_helper"

class WalletEntryTest < ActiveSupport::TestCase
  setup do
    @user = User.create!(name: "Bilbo Bolseiro", email: "bilbo@shire.com")
  end

  test "deve calcular o saldo corretamente após um crédito e um débito" do
    @user.wallet_entries.create!(amount: 100, entry_type: :credit, description: "Depósito inicial")
    @user.wallet_entries.create!(amount: 40, entry_type: :debit, description: "Compra de anel")

    assert_equal 60, @user.current_balance, "O saldo deveria ser 60 após as transações"
  end

  test "não deve permitir criar entrada sem valor" do
    entry = @user.wallet_entries.build(entry_type: :credit)
    assert_not entry.save, "Salvou uma entrada sem valor (amount)"
  end
end
