module Intents
  class CancelIntent < IntentHandler
    def handle(slots, session_attributes)
     answer ['aww','damn','sorry','ohh'].sample
    end
  end
end
