require_relative 'lib/clonewars'

# The App class defines the routes and behavior for the Clone Wars application.
class App < CloneWars

  # Defines the root route "/".
  #
  # @return [String] A welcome message.
  r.get '/' do 
    "Welcome to Clone Wars!"
  end

  # Defines a route for "/banan/:id", capturing the `id` parameter.
  #
  # @param [String] id The dynamic part of the route (e.g., "/banan/123").
  #
  # @return [String] A response string ("woot").
  r.get "/banan/:id" do |id|
    "woot"
  end


  # Defines a route for "/dude/:id/:name", capturing the `id` and `name` parameters.
  #
  # @param [String] id The dynamic `id` parameter (e.g., "/dude/123/john").
  # @param [String] name The dynamic `name` parameter (e.g., "/dude/123/john").
  #
  # @return [String] A personalized message.
  r.get '/dude/:id/:name' do |id, name|
    "Wassup #{name}! Your id is #{id}, #{name} ;)!"
  end
end

# Runs the application
App.run
