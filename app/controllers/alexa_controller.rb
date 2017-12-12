class AlexaController < ApplicationController
  before_action :authenticate
  def index
    body = JSON.parse(request.body.read)
    ap body
    req = body['request']
    if req['type'] == "LaunchRequest"
      launch_request and return
    elsif req['type'] == "SessionEndedRequest"
      end_request and return
    else
      @intent = body['request']['intent']
      @intent_slots = @intent['slots']
      @session_attributes = body['session']['attributes'] || {}
      @handler = handler_klass.new
      answer = @handler.handle(@current_user, @intent_slots, @session_attributes)
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
            text: "Hello #{@current_user.name}"
          }
      }
    }.to_json
  end

  def end_request
    render json: {
      version: "1.0"
    }.to_json
  end

  def authenticate
    body = JSON.parse(request.body.read)
    session =  body['session']
    app_id = session['application']['applicationId']
    # byebug
    render json: {error: "not allowed"}, status: 401 unless app_id == ENV.fetch('ALEXA_APP_ID')
    device_id = body['context']['System']['device']['deviceId']
    @current_user = User.find_by(device_id: device_id)

    if @current_user == nil
      render json: {
        version: "1.0",
        response: {
          shouldEndSession: true,
          outputSpeech: {
              type: "PlainText",
              text: 'You need to connect your device id'
            },
          card: {
            type: "Simple",
            title: "Your device Id",
            content: device_id
          }
        }
      }.to_json
    end
  end
end
