module Intents
  class HelpIntent < IntentHandler
    def handle(current_user, slots, session_attributes)
      answer ["You could say something like 'I bought a phone for 100 euros' or ask what you spent money on"].sample
    end
  end
end
