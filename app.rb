require_relative 'time_handler'

class App
  def call(env)
    @request = Rack::Request.new(env)
    if @request.path == '/time'
      format_params = @request.params['format'].split(',')
      time = TimeHandler.new(format_params)
      response(time.status, time.response)
    else
      response(404, 'Not Found')
    end
  end

  private

  def response(status, body)
    [
      status,
      { 'Content-Type' => 'text/plain' },
      [body + "\n"]
    ]
  end
end
