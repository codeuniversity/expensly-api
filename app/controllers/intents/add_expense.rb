module Intents
  class AddExpense < IntentHandler
    def handle(slots, session_attributes={})
     @article = slots['article']['value']
      @amount = slots['amount']['value']
      slot_info = {article: @article, amount: @amount}
      session_info = {article: session_attributes['article'], amount: session_attributes['amount']}
      ap slot_info
      ap session_info
      info = session_info.merge(slot_info.compact).compact
      ap info
      if info[:article] && info[:amount]
        ask("I am going to add #{info[:article]}, for #{info[:amount]} euros", info)
      elsif !info[:article]
        ask('What did you buy?', info)
      elsif !info[:amount]
        ask('How much did you pay?', info)
      end

    end
  end
end
