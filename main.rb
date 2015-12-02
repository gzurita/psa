require 'sinatra'
require 'sinatra/reloader' if development?
require './employee'

get '/list_employees' do
  @employees = Employee.all
  erb :list_employees
end

get '/new_employee' do
  @employee = Employee.new
  erb :new_employee do 
    erb :form_employee
  end
end

post '/new_employee' do
  logger.info params[:employee]
  e = Employee.new
  e.first_name = params[:employee][:first_name]
  e.last_name = params[:employee][:last_name]
  e.save
  redirect to '/list_employees'
end

get '/employees/:id' do
  @employee = Employee.get(params[:id])
  erb :edit_employee do
    erb :form_employee
  end
end

put '/employees/:id' do
  e = Employee.get(params[:id])
  e.update(params[:employee])
  redirect to '/list_employees'
end

post '/employees' do
  e = Employee.create(params[:employee])
  e.save
  redirect to '/list_employees'
end




get '/delete_employee/:id' do
  Employee.get(params[:id]).destroy
  redirect to 'list_employees'
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


