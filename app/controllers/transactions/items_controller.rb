class Transactions::ItemsController < ItemsController
	before_action :set_transaction

	private

	def set_transaction
		@transaction = Transaction.find(params[:transaction_id])
	end
end
