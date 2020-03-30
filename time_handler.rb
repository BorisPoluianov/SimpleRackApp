class TimeHandler
  attr_reader :status, :response

  VALID_FORMATS = {
    'year' => '%Y-', 'month' => '%m-', 'day' => '%d',
    'hour' => '%H:', 'minute' => '%M:', 'second' => '%S'
  }.freeze

  def initialize(params)
    @valid = ''
    @unvalid = []
    @response = time_format(params)
  end

  private

  def time_format(params)
    parse(params)

    return unvalid_format unless @unvalid.empty?
    time_output
  end

  def unvalid_format
    @status = 400
    "Unvalid time format: "+ @unvalid *  ", "
  end

  def time_output
    @status = 200
    Time.now.strftime(@valid)
  end

  def parse(params)
    params.each do |format|
      if VALID_FORMATS[format]
        @valid += VALID_FORMATS[format]
      else
        @unvalid << format
      end
    end
  end
end
