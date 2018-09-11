get '/people' do
  @people = Person.all
  erb :"/people/index"
end

#get '/' do  #had in my code, not in answer code. still need?
#  @people = Person.all
#  erb :"/people/index"
#end

# must be before get'/:id' so a new person is done by default (reword)
get '/people/new' do
  @person = Person.new
  erb :"/people/new"
end

#get '/new' do  #had in my code, not in answer code. still need?
#  erb :"/people/new"
#end

post '/people' do
  if params[:birthdate].include?("-")
    birthdate = params[:birthdate]
  else
    birthdate = Date.strptime(params[:birthdate], "%m%d%Y")
  end

  person = Person.create(first_name: params[:first_name], last_name: params[:last_name], birthdate: birthdate)

  redirect "/people/#{person.id}"
end

get '/people/:id' do
  @person = Person.find(params[:id])
  birth_path_num = Person.get_birth_path_num(@person.birthdate.strftime("%m%d%Y"))
  @message = Person.get_message(birth_path_num)
  erb :"/people/show"
end

#get '/:id' do  #had in my code, not in answer code. still need?
#  @person = Person.find(params[:id])
#  erb :"people/show"
#end
