class TimeService

  FORMATS = {
    'year' => '%Y',
    'month' => '%m',
    'day' => '%d',
    'hour' => '%H',
    'minute' => '%M',
    'second' => '%S'
  }.freeze

  def initialize(formats)
    @formats = formats['format'] ? formats['format'].split(',') : []
  end

  def success?
    unknown_formats.empty? && @formats.any?
  end

  def answer
    if success?
      [Time.now.strftime(time_params) + "\n\n"]
    else
      ["Unknown time format [#{@unknown_formats.join(", ")}]\n\n", help]
    end
  end

  private

  def time_params
    FORMATS.values_at(*@formats).join('-')
  end

  def help
    "Example valid request: /time?format=year,month,day\n" +
      "Available time formats: #{FORMATS.keys.join(", ")}\n\n"
  end

  def unknown_formats
    @unknown_formats ||= @formats - FORMATS.keys
  end
end
