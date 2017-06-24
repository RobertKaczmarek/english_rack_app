require 'json'

class Suggest
  def self.call(env)
    req = Rack::Request.new(env)

    word = req.path_info.gsub('/', '')
    [200, { 'Content-Type' => 'application/json' }, [{ x: word }.to_json] ]
  end
end
