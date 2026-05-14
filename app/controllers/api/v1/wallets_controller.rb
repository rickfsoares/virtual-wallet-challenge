module Api
  module V1
    class WalletsController < ActionController::API
      before_action :set_user

      # 1. Saldo atual: GET /api/v1/users/:id/balance
      def balance
        render json: { 
          user: @user.name, 
          balance: @user.current_balance 
        }, status: :ok
      end

      # 2. Crédito/Débito: POST /api/v1/users/:id/entries
      def create_entry
        entry = @user.wallet_entries.build(entry_params)
        
        if entry.save
          render json: { 
            message: "Transação realizada com sucesso", 
            current_balance: @user.reload.current_balance 
          }, status: :created
        else
          render json: { errors: entry.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # 3. Extrato por período: GET /api/v1/users/:id/entries?start_date=YYYY-MM-DD&end_date=YYYY-MM-DD
      def index_period
        # Tratamento básico para datas
        start_param = params[:start_date] || 7.days.ago.to_s
        end_param = params[:end_date] || Date.today.to_s

        start_date = start_param.to_date.beginning_of_day
        end_date = end_param.to_date.end_of_day
       
        entries = @user.wallet_entries.where(created_at: start_date..end_date).order(created_at: :desc)
        
        render json: entries, status: :ok
      rescue StandardError => e
        render json: { error: "Formato de data inválido ou parâmetros ausentes" }, status: :bad_request
      end

      private

      def set_user
        @user = User.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Usuário não encontrado" }, status: :not_found
      end

      def entry_params
        params.permit(:amount, :entry_type, :description)
      end
    end
  end
end
