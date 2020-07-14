require_relative 'timeprocessor'

class App
  def time(env)
    return not_found(env) unless env['REQUEST_METHOD'] == 'GET'

    time = TimeProcessor.new
    time.call(env)
  end

  def not_found(_)
    [404, { 'Content-Type' => 'text/plain' }, ['Not found']]
  end
end
