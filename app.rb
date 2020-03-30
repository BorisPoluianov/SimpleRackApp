require_relative 'time_handler'

class App
  def call(env)
    @request = Rack::Request.new(env)
    if @request.path == '/time'
      format_params = @request.params['format'].split(',')
      time = TimeHandler.new(format_params)
      response(time.status, time.response + "\n")
    else
      response(404, 'Not Found')
    end
  end

  private

  def response(code, text)
    [
      code,
      { 'Content-Type' => 'text/plain' },
      [text]
    ]
  end
end
