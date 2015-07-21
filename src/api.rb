#encoding: utf-8
require 'sinatra'
require_relative 'model.rb'


class Api < Sinatra::Base
  before do
    headers['Access-Control-Allow-Methods'] = 'GET, POST, DELETE'
    headers['Access-Control-Allow-Origin'] = 'http://localhost:9000'
    headers['Access-Control-Allow-Headers'] = 'accept, authorization, origin'
    body = request.body.read
    @body = JSON.parse(body) unless body.empty?
  end
  get '/' do
    'Welcome to SorgoCom'
  end
  post '/event' do
    halt 400 if @body['name'].nil?
    Events.insert(name: @body['name'])
  end
  get '/event' do
      Events.to_json
  end
  get '/event/:id' do
    Events.filter(:id => params[:id]).to_json
  end
  get '/event/:id/match' do
    Match.filter(:fk_event => params[:id]).to_json
  end

  post '/match' do
    halt 400 if @body['team_a'].nil?
    Match.insert(team_a: @body['team_a'], team_b: @body['team_b'], fk_event: @body['event'])
  end
  get '/match' do
    Match.to_json
  end


  post '/bet' do
    halt 400 if @body['email'].nil?
    Bet.insert(email: @body['email'], fk_event: @body['event'])
  end
  get '/bet/:user' do
    Bet.filter(:email => params[:user]).to_json
  end
end
