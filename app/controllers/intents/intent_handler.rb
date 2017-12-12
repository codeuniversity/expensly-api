module Intents
  class IntentHandler
    def answer(text, opts={})
      {
        version: "1.0",
        sessionAttributes: opts[:session_attributes],
        response: {
          outputSpeech: {
              type: "PlainText",
              text: text
            }
        }
      }.to_json
    end

    def ask(text, opts={})
      {
        version: "1.0",
        sessionAttributes: opts,
        response: {
          shouldEndSession: false,
          outputSpeech: {
              type: "PlainText",
              text: text
            }
        }
      }.to_json
    end
  end
end

