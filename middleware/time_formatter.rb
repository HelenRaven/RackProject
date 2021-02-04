class TimeFormatter

  PARAMS = {
    year: Time.now.year,
    month: Time.now.month,
    day: Time.now.day,
    hour: Time.now.hour,
    minute: Time.now.min,
    second: Time.now.sec
  }

  attr_reader :time_ary, :invalid_ary

  def initialize(env)
    @env = env
    @time_ary = []
    @invalid_ary = []
    call
  end

  def call
    request = @env["QUERY_STRING"].gsub!("format=",'').split("%2C")
    if success?
      time(request)
      invalid(request)
    end
  end

  def success?
    @env["REQUEST_PATH"] == "/time"
  end

  private

  def time(request)
    request.each do |param|
      param = param.to_sym
      @time_ary << PARAMS[param].to_s if PARAMS[param]
    end

  end

  def invalid(request)
    request.each do |param|
      param = param.to_sym
      @invalid_ary << param.to_s unless PARAMS[param]
    end
  end

end
