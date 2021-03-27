require 'sinatra'

class IdeaBoxApp < Sinatra::Base
  get '/' do
    "<h1>Hello, World!</h1><blockquote>I guess I always felt even if the world came to an end, I will take a stand</blockquote>"
  end
end
