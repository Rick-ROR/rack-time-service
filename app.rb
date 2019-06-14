require_relative 'time_service'

class App

  def call(env)
    request = Rack::Request.new(env)

    if request.path_info == '/time'
      Rack::Response.new(*request_time(request.params))
    else
      Rack::Response.new(*request_404)
    end
  end

  private

  def headers
    { 'Content-Type' => 'text/plain' }
  end

  def request_404
    [["Page not found. Try /time?help\n\n"], 404, headers]
  end

  def request_time(params)
    time = TimeService.new(params)

    if time.success?
      [time.answer, 200, headers]
    else
      [time.answer, 400, headers]
    end

  end

end
