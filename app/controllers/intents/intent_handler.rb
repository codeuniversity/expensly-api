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

    def get_article_for(name, current_user)
      current_user.articles.where('LOWER(name) LIKE LOWER(?)', "%#{name}%").first
    end

    def get_category_for(name, current_user)
      current_user.articles.where('LOWER(name) LIKE LOWER(?)', "%#{name}%").first
    end

  end
end

