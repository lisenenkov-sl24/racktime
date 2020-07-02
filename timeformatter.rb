class TimeFormatter
  FORMAT_PARTS = { 'year' => 'Y', 'month' => 'm', 'day' => 'd', 'hour' => 'H', 'minute' => 'M', 'second' => 'S' }.freeze

  def generate_time(format, error_params)
    time_format = []
    unless format.nil? || format == ''
      format.split(',').each do |f|
        time_f = FORMAT_PARTS[f]
        if time_f.nil?
          error_params.push f
        else
          time_format.push "%#{time_f}"
        end
      end
    end
    Time.now.strftime time_format.join('-')
  end
end
