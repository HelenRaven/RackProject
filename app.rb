class App

  def call(env)
    @response = TimeFormatter.new(env)
    [status, headers, body]
  end

  private

  def status
    if @response.success?
      @response.invalid_ary.empty? ? 200 : 400
    else
      404
    end
  end

  def headers
    {"Content-type" => "text/plain"}
  end

  def body
    if @response.invalid_ary.empty?
      [@response.time_ary*"-"]
    else
      ["Unknown time format" + @response.invalid_ary.to_s ]
    end
  end

end
