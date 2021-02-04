class TimeFormatter

  PARAMS = {
    year: "%Y",
    month: "%m",
    day: "%d",
    hour: "%H",
    minute: "%M",
    second: "%S"
  }

  def initialize(params)
    @params = params
    @time_ary = []
    @invalid_ary = []
  end

  def call
    time = Time.now

    @params.each do |param|
      if PARAMS[param.to_sym]
        @time_ary << time.strftime(PARAMS[param.to_sym])
      else
        @invalid_ary << param
      end
    end
  end

  def success?
    @invalid_ary.empty?
  end

  def get_result
    if success?
      @time_ary*"-"
    else
      "Unknown time format " + @invalid_ary.to_s
    end
  end

end
