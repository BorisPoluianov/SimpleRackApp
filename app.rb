require_relative 'time_handler'

class App
  HEADER = { 'Content-Type' => 'text/plain' }.freeze

  def call(env)
    @request = Rack::Request.new(env)

    if @request.path_info == '/time'
      params? ? handle_time : response('Params not given', 400)
    else
      response('Not Found', 404)
    end
  end

  private

  def params?
    !@request.params['format'].nil?
  end

  def handle_time
    format_params = @request.params['format'].split(',')
    time_handler = TimeHandler.new(format_params)
    time_handler.call

    if time_handler.format_valid?
      status = 200
      body = time_handler.time_in_format
    else
      status = 400
      body = time_handler.error
    end

    response(body, status)
  end

  def response(body, status)
    Rack::Response.new(body + "\n", status, HEADER).finish
  end
end
