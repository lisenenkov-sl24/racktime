class App
  def time(env)
    return not_found(env) unless env['REQUEST_METHOD'] == 'GET'

    params = Rack::Utils.parse_nested_query(env['QUERY_STRING'])

    time = generate_time(params['format'], error_params = [])

    return [400, { 'Content-Type' => 'text/plain' }, ["Unknown time format #{error_params}"]] if error_params.size > 0

    [200, { 'Content-Type' => 'text/plain' }, [time]]
  end

  def not_found(_)
    [404, { 'Content-Type' => 'text/plain' }, ['Not found']]
  end

  private

  def generate_time(format, error_params)
    time_format = []
    unless format.nil? || format == ''
      format.split(',').each do |f|
        time_f = { 'year' => 'Y', 'month' => 'm', 'day' => 'd', 'hour' => 'H', 'minute' => 'M', 'second' => 'S' }[f]
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
