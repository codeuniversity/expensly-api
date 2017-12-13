module Intents
  class AddExpense < IntentHandler
    def handle(current_user, slots, session_attributes={})
      session_info = session_attributes.symbolize_keys
      if session_info[:asked_for_category]
        category = slots['article']['value']
        article = session_info[:article]
      else
        article = slots['article']['value']
      end

      amount = slots['amount']['value']
      slot_info = {article: article, amount: amount}
      info = session_info.merge(slot_info.compact).compact
      article = info[:article]
      amount = info[:amount]
      if article && amount
        a = get_article_for(article, current_user)
        if a == nil
          if session_info[:asked_for_category] && category
            items = info[:items]&.map(&:symbolize_keys) || []
            items.push({article: info[:article], amount: info[:amount], category: category})
            info[:items] = items
            total = 0
            items.each {|item| total += item[:amount].to_f}
            info[:article] = nil
            info[:amount] = nil
            info[:asked_for_category] = nil
          return ask("I am adding a #{category}, #{article}, for #{amount} euros. You have a total of #{total} in this transaction now.", info)
          elsif session_info[:asked_for_category]
          else
            info[:asked_for_category] = true
            return ask("I don't know #{article}, what category does it belong to?", info)
          end
        end
        items = info[:items]&.map(&:symbolize_keys) || []
        items.push({article: info[:article], amount: info[:amount]})
        info[:items] = items
        total = 0
        items.each {|item| total += item[:amount].to_f}
        info[:article] = nil
        info[:amount] = nil
        ask("I am adding #{article}, for #{amount} euros. You have a total of #{total} in this transaction now.", info)
      elsif !article
        ask('What did you buy?', info)
      elsif !amount
        ask('How much did you pay?', info)
      end

    end
  end
end
