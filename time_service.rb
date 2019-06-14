class TimeService

  def initialize(formats)
    @formats = formats['format'] ? formats['format'].split(',') : []
    @answer = {}
  end

  FORMATS = {
    'year' => '%Y',
    'month' => '%m',
    'day' => '%d',
    'hour' => '%H',
    'minute' => '%M',
    'second' => '%S'
  }.freeze

  def time_params
    FORMATS.values_at(*@formats).join('-')
  end

  def help
    @answer[:body] = "Example valid request: /time?format=year,month,day\n" +
                      "Available time formats: #{FORMATS.keys.join(", ")}\n\n"
  end

  def unknown_formats
    @unknown_formats ||= @formats - FORMATS.keys
  end

  def answer
    if unknown_formats.empty? && @formats.any?
      @answer[:status] = 200
      @answer[:body] = Time.now.strftime(time_params) + "\n\n"
    else
      @answer[:status] = 400
      @answer[:body] = ["Unknown time format [#{@unknown_formats.join(", ")}]\n\n", help]
    end

    @answer
  end

end
