module Intents
  class HelpIntent < IntentHandler
    handle(slots, session_attributes)
      answer ["You could say something like 'I added bla into blup' or ask where you put something"].sample
    end
  end
end
