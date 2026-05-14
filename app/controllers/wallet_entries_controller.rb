class WalletEntriesController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    @entry = @user.wallet_entries.build(wallet_entry_params)

    if @entry.save
      redirect_to user_path(@user), notice: "Transação realizada com sucesso!"
    else
      redirect_to user_path(@user), alert: "Erro: #{@entry.errors.full_messages.to_sentence}"
    end
  end

  private

  def wallet_entry_params
    params.require(:wallet_entry).permit(:amount, :entry_type, :description)
  end
end
