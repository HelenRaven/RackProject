class RackTime

  PARAMS = {
    year: Time.now.year,
    month: Time.now.month,
    day: Time.now.day,
    hour: Time.now.hour,
    minute: Time.now.min,
    second: Time.now.sec
  }

  def initialize(app)
    @app = app
  end

  def call(env)
    @app.call(env)
    @req = Rack::Request.new(env)
    @res = Rack::Response.new
    headers
    body
    @res.finish
  end

  def headers
    @res['Content-Type'] = 'text/plain'
  end

  def body
    format = @req.params["format"]
    if format
      set_param(format)
    else
      @res.status = 400
      @res.write("No format found")
    end
  end

  def set_param(format)
    success = ""
    failure = ""

    format.split(",").each do |param|
      param = param.to_sym

      if PARAMS[param]
        success += PARAMS[param].to_s + '-'
      else
        failure += param.to_s + ','
      end
    end

    if failure == ""
      @res.write(success.chop)
    else
      @res.status = 400
      @res.write("Unknown time format [" + failure.chop + "]")
    end
  end

end
