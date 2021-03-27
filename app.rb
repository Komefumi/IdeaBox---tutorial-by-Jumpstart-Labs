require 'sinatra'

class IdeaBoxApp < Sinatra::Base
  get '/' do
    "Hello, World!"
  end
end

=begin
get '/' do
  "Hello, World!"
end
=end
