module Intents
  class ListExpense < IntentHandler
    def handle(slots, session_attributes)
      transactions = Transaction.order(created_at: :desc).limit(10)

      answer "Here are the 10 most recent expenses:
      #{transactions.map{|transaction| "#{transaction.name}: #{transaction.items.sum('items.price * items.amount')}euro" }.join(', ')}"
    end
  end
end
