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
    @unvalid = []
    @requested_format = format_params
  end

  def call
    parse
    if format_valid?
      time_in_format
    else
      error
    end
  end

  def format_valid?
    @unvalid.empty?
  end

  private

  def error
    "Unvalid time format: "+ @unvalid * ", "
  end

  def time_in_format
    Time.now.strftime(@valid)
  end

  def parse
    @requested_format.each do |format|
      if VALID_FORMATS[format]
        @valid += VALID_FORMATS[format]
      else
        @unvalid << format
      end
    end
  end
end
