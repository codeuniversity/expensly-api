class AlexaController < ApplicationController

    def index
      body = JSON.parse(request.body.read)
      # ap body
      req = body['request']
      # ap req
      if req['type'] == "LaunchRequest"
        launch_request and return
      elsif req['type'] == "SessionEndedRequest"
        end_request and return
      else
        @intent = body['request']['intent']
        @intent_slots = @intent['slots']
        byebug
        @session_attributes = body['session']['attributes'] || {}
        @handler = handler_klass.new
        answer = @handler.handle(@intent_slots, @session_attributes)
        ap answer
        render json: answer

      end
    end

    private

    def handler_klass
      Intents.const_get(@intent['name'].classify)
    end

    def launch_request
      render json: {
        version: "1.0",
        response: {
          shouldEndSession: false,
          outputSpeech: {
              type: "PlainText",
              text: 'Hello, Alex'
            }
        }
      }.to_json
    end

    def end_request
      render json: {
        version: "1.0"
      }.to_json
    end
  end
