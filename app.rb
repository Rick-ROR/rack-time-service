require_relative 'time_service'

class App

  def call(env)
    request = Rack::Request.new(env)

    if request.path_info == /time/
      [status, headers, body]
    else
      request_404
    end
  end

  private

  def status
    200
  end

  def headers
    { 'Content-Type' => 'text/plain' }
  end

  def body
    ["Welcome to the real World.\n"]
  end

  def request_404
    Rack::Response.new(["Page not found. Try /time?format=year\n\n"], 404, headers)
  end

  def request_time

  end

end
