require 'sinatra'
require 'sinatra/reloader' if development?
require './employee'

get '/' do
  'It works!'
end

post '/employees' do
  logger.info params[:employee]
  e = Employee.create(params[:employee])
  e.save
end

get '/employees' do
  if Employee.count > 0 
    Employee.all.to_json
  else
    "No employees"
  end
end

delete '/employee/:id' do
  e = Employee.get(params[:id])
  if e.nil?
    status 404
  else
    e.destroy
  end
end 


