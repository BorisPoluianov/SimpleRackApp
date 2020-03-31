class TimeHandler
  VALID_FORMATS = {
    'year' => '%Y-',
    'month' => '%m-',
    'day' => '%d',
    'hour' => '%H:',
    'minute' => '%M:',
    'second' => '%S'
  }.freeze

  def initialize(format_params)
    @valid = ''
    @invalid = []
    @requested_format = format_params
  end

  def call
    parse
  end

  def format_valid?
    @invalid.empty?
  end

  def error
    "Invalid time format: "+ @invalid * ", "
  end

  def time_in_format
    Time.now.strftime(@valid)
  end

  private

  def parse
    @requested_format.each do |format|
      if VALID_FORMATS[format]
        @valid += VALID_FORMATS[format]
      else
        @invalid << format
      end
    end
  end
end
