require_relative 'app'

app = App.new

application = Rack::Builder.app do
  map '/time' do
    run app.method(:time)
  end
  map '/' do
    run app.method(:not_found)
  end
end

run application