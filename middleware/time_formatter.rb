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
    @time_array = []
    @invalid_array = []
  end

  def call
    @params.each do |param|
      if PARAMS[param.to_sym]
        @time_array << PARAMS[param.to_sym]
      else
        @invalid_array << param
      end
    end
  end

  def success?
    @invalid_array.empty?
  end

  def time
    Time.now.strftime(@time_array*"-")
  end

  def invalid
    "Unknown time format " + @invalid_array.to_s
  end

end
