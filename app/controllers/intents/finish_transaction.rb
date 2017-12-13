module Intents
  class FinishTransaction < IntentHandler
    def handle(current_user, slots, session_attributes={})
      slot_info = {transaction_name: slots['transactionName']['value']}
      info = session_attributes.merge(slot_info.compact).compact.symbolize_keys
      transaction_name = info[:transaction_name]
      items = info[:items]&.map(&:symbolize_keys) || []
      return ask("You need to add items first, for example by saying: 'I bought a car for 200 euros'",{}) if items.length == 0

      return ask("Please provide a transaction name, for example by saying: 'Save Transaction groceries'", info) if !transaction_name

      Transaction.transaction do
        t = Transaction.create(user: current_user, name: transaction_name)
        t.save!
        items.each do |item_info|
          a = get_article_for(item_info[:article], current_user)
          if a != nil
          item = Item.new(user: current_user, article: a, price: item_info[:amount], change: t)
            item.save!
          elsif item_info[:category]
            c = get_category_for(item_info[:category], current_user) || Category.create(name: item_info[:category], user: current_user)
            a = Article.create(category: c, name: item_info[:article], user: current_user)
            item = Item.create(user: current_user, article: a, price: item_info[:amount], change: t)
          else
            raise ActiveRecord::Rollback, answer("I dont know what to do here, please investigate")
          end
        end
        return answer("I saved #{transaction_name}")
      end
    end
  end
end
