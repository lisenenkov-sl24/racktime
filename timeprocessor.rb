require_relative 'timeformatter'

class TimeProcessor
  def call(env)
    params = Rack::Utils.parse_nested_query(env['QUERY_STRING'])

    formatter = TimeFormatter.new
    time = formatter.generate_time(params['format'], error_params = [])

    return [400, { 'Content-Type' => 'text/plain' }, ["Unknown time format [#{error_params.join(', ')}]"]] unless error_params.empty?

    [200, { 'Content-Type' => 'text/plain' }, [time]]
  end
end
