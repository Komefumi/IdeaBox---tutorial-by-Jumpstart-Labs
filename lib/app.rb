# frozen_string_literal: true

require 'sinatra'

require 'idea_box'

# This is the main application class
class IdeaBoxApp < Sinatra::Base
  use Rack::MethodOverride
  configure do
    set :views, 'lib/app/views/'
    set :public_dir, 'public'
    # set :method_override, true
  end

  get '/' do
    name = params[:name] || 'Bob'
    puts params
    locals = { name: name, ideas: IdeaStore.all }
    if params[:idea_updated] && params[:success]
      locals[:idea_updated] = true
      locals[:updated_idea] = IdeaStore.find(params[:updated_id].to_i)
    end
    erb(:index, { locals: locals })
  end

  post '/' do
    IdeaStore.create(params[:idea])
    redirect '/'
  end

  delete '/:id' do |id|
    IdeaStore.delete(id.to_i)
    redirect '/'
  end

  put '/:id' do |id|
    # 'Tweaking the IDEA!'
    data = params[:idea]
    IdeaStore.update(id.to_i, data)
    redirect "/?idea_updated=true&success=true&updated_id=#{id}"
  end

  get '/:id/edit' do |id|
    idea = IdeaStore.find(id.to_i)
    erb :edit, locals: { id: id, idea: idea }
  end

  not_found do
    erb :error
  end
end
