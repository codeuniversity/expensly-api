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
        t = Transaction.new(user: current_user, name: transaction_name)
        t.save!
        items.each do |item_info|
          a = get_article_for(item_info[:article], current_user)
          c = a.category
          if a.id != nil
          item = Item.new(user: current_user, article: a, price: item_info[:amount], change: t)
            item.save!
          else
            #TODO: ask for category
            raise ActiveRecord::Rollback, answer("I dont know a fitting category")
          end
        end
        return answer("I saved #{transaction_name}")
      end


    end

    private

    def get_article_for(name, current_user)
      current_user.articles.where('LOWER(name) LIKE LOWER(?)', "%#{name}%").first || Article.new(user: current_user, name: name)
    end

    def get_category_for(name, current_user)
      current_user.articles.where('LOWER(name) LIKE LOWER(?)', "%#{name}%").first || Category.new(user: current_user, name: name)
    end

  end
end
