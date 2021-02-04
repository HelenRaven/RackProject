class App

  CORRECT_PATH = "/time"
  PARAMS_KEY = "format"

  def call(env)
    request = Rack::Request.new(env)
    params = request.params[PARAMS_KEY]

    if env["REQUEST_PATH"] == CORRECT_PATH && params
      process_params(params)
    else
      response("unknown path", 404)
    end
  end

  private

  def response(body, status)
    header = {"Content-Type" => "text/plain"}
    Rack::Response.new(body, status, header).finish
  end

  def process_params(params)
    tf = TimeFormatter.new(params.split(','))
    tf.call

    if tf.success?
      response(tf.get_result, 200)
    else
      response(tf.get_result, 400)
    end
  end

end
