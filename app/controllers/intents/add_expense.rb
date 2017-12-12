module Intents
  class AddExpense < IntentHandler
    def handle(current_user, slots, session_attributes={})
     @article = slots['article']['value']
      @amount = slots['amount']['value']
      slot_info = {article: @article, amount: @amount}
      ap slot_info
      info = session_attributes.symbolize_keys.merge(slot_info.compact).compact
      ap info
      article = info[:article]
      amount = info[:amount]
      if article && amount
        items = info[:items]&.map(&:symbolize_keys) || []
        items.push({article: info[:article], amount: info[:amount]})
        info[:items] = items
        total = 0
        ap info
        items.each {|item| total += item[:amount].to_f}
        # byebug
        ap total
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
