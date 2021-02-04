class App

  CORRECT_PATH = "/time"
  PARAMS_KEY = "format"

  def call(env)
    request = Rack::Request.new(env)
    response(env["REQUEST_PATH"],request.params)
  end

  private

  def response(path, params)
    @response = Rack::Response.new
    headers

    if path == CORRECT_PATH && params[PARAMS_KEY]
      time = TimeFormatter.new(params[PARAMS_KEY].split(','))
      time.call
      status(time.success?)
      body(time.get_result)
    else
      @response.status = 404
    end

    @response.finish
  end

  def status(success)
    @response.status = success ? 200 : 400
  end

  def headers
    @response.set_header("Content-type","text/plain")
  end

  def body(body)
    @response.write(body)
  end

end
