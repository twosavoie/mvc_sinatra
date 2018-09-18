get '/people' do
  @people = Person.all
  erb :"/people/index"
end

# must be before get'/:id' so a new person is done by default (reword)
get '/people/new' do
  @person = Person.new
  erb :"/people/new"
end

post '/people' do
# if input.match(/^[0-9]+[0-9]$/).nil?
#    @error = "You should enter a valid birthdate in the form of mmddyyyy."
#    erb :form
#  end #Didn't work at all

birthdate = params[:birthdate].tr("/-", "") #This allows ""-/ in /
if Person.valid_birthdate(birthdate)
  birth_path_num = Person.get_birth_path_num(birthdate)
  redirect "/message/#{birth_path_num}"
else
  @error = "You should enter a valid birthdate in the form of mmddyyyy."
  erb :form
end


#  if params[:birthdate].include?("-")
#  if params[:birthdate].include?("-/") doesn't work
#    birthdate = params[:birthdate]
#  else
#    birthdate = Date.strptime(params[:birthdate], "%m%d%Y")
#  else
#    erb :"/people/new"  #made a new person with dashes in Safari. Then after I wrote this it didn't (11-11-1111 works still) but did give me the error.
#  end


#  @person = Person.new(first_name: params[:first_name], last_name: params[:last_name], birthdate: birthdate)
#this works as expected, getting errors in both Google and Safari. However, date must be input with slashes in safari to work. Doesn't work with dashes or 8 straight numers. This is no longer true - actually the opposite. I don't kow what changed :)

  @person = Person.new(first_name: params[:first_name], last_name: params[:last_name], birthdate: birthdate)

  if @person.valid? #use to check if the date is actually there
    @person.save
    redirect "/people/#{@person.id}"
  else #first & last name work, birthdate doesn't (?)
    @person.errors.full_messages.each do |msg|
      @errors = "#{@errors} #{msg}."
    end
    erb :"/people/new"
  end
end


# Use ActiveRecord method "find" to find the record using the id in params

get '/people/:id/edit' do
  @person = Person.find(params[:id])
  erb :'/people/edit'
end

put '/people/:id' do
  @person= Person.find(params[:id])
  @person.first_name = params[:first_name]
  @person.last_name = params[:last_name]
  @person.birthdate = params[:birthdate]
  if @person.valid?
    @person.save
    redirect "/people/#{@person.id}"
  else
    @person.errors.full_messages.each do |msg|
      @errors = "#{@errors} #{msg}."
    end
    erb :"/people/edit"
  end
end

delete '/people/:id' do
  person = Person.find(params[:id])
  person.delete
  redirect "/people"
end

get '/people/:id' do
  @person = Person.find(params[:id])
  birth_path_num = Person.get_birth_path_num(@person.birthdate.strftime("%m%d%Y"))
  @message = Person.get_message(birth_path_num)
  erb :"/people/show"
end
