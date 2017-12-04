class Transactions::ItemsController < ItemsController
	before_action :set_transaction

	private

	def set_transaction
		@transaction = Transaction.find(params[:transaction_id])
		render json: {error: 'not allowed'}, status: 401 unless @transaction.user == @current_user
	end
end
