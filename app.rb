
require_relative 'lib/clonewars'



class App < CloneWars
  r.get "/banan/:id" do |id|
    "woot"
  end
  
  
  r.get '/' do 
    "Welcome to Clone Wars!"
  end
  
  r.get '/dude/:id/:name' do |id, name|
    "Wassup #{name}! Your id is #{id}, #{name} ;)!"
  end
end


App.run