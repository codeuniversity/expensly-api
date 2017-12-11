class Transactions::ItemsController < ItemsController
	before_action :set_transaction

	private

	def set_transaction
		@container = Transaction.find(params[:transaction_id])
		render json: {error: 'not allowed'}, status: 401 unless @container.user == @current_user
	end
end
