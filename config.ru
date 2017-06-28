require './pronounce'
require './suggest'


map '/pronounce' do
  run Pronounce
end

map '/suggest' do
  run Suggest
end
