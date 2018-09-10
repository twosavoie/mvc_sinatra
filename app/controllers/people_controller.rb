get '/people' do
  @people = Person.all
  erb :"/people/index"
end

get '/people/:id' do
  @person = Person.find(params[:id])
  birth_path_num = Person.get_birth_path_num(@person.birthdate.strftime("%m%d%Y"))
  @message = Person.get_message(birth_path_num)
  erb :"/people/show"
  #{}"This is a person show page!"
end
