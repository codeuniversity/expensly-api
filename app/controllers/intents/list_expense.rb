module Intents
  class ListExpense < IntentHandler
    def handle(current_user, slots, session_attributes)
      transactions = current_user.transactions.order(created_at: :desc).limit(10)

      answer "Here are your #{transactions.length} most recent expenses:
      #{transactions.map{|transaction| "#{transaction.name}: #{transaction.items.sum('items.price * items.amount')}euros" }.join(', ')}"
    end
  end
end
