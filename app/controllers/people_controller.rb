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
#  birthdate = params[:birthdate].tr("/-", "")
#birthdate = Date.strptime(params[:birthdate].gsub("/''", "-"), "%m%d%Y") #try tomorrow #need to convert string to date. Putting in date works already
#puts birthdate.inspect
  @person = Person.new(first_name: params[:first_name], last_name: params[:last_name], birthdate: params[:birthdate])
  puts params.inspect
  if @person.valid?
    @person.save
    redirect "/people/#{@person.id}"
  else
    @person.errors.full_messages.each do |msg|
    @errors = "#{@errors} #{msg}."
    puts params[:birthdate].inspect
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

#birthdate = params[:birthdate].gsub("/-", " ") #This allows ""-/ in /
#if Person.valid_birthdate(birthdate)
 #birth_path_num = Person.get_birth_path_num(birthdate)
  #redirect "/message/#{birth_path_num}"
#else
#  @error = "You should enter a valid birthdate in the form of mmddyyyy."
#  erb :form #don't think I need this
#end

# dashes give error need to be "" /'s give error page
#gsub("/", "") good for /'scan(/pattern/) { |match|  }'

#works
#if params[:birthdate].include?("-")
#  birthdate = params[:birthdate]
#else
#  birthdate = Date.strptime(params[:birthdate].tr("/", ""), "%m%d%Y")
#end
# params[:birthdate].tr("/-", ""))
#@person = Person.new(first_name: params[:first_name], last_name: params[:last_name], birthdate: birthdate)

#if @person.valid? #use to check if the date is actually there
#  @person.save
#  redirect "/people/#{@person.id}"
#else #first & last name work, birthdate doesn't (?)
#  @person.errors.full_messages.each do |msg|
#  @errors = "#{@errors} #{msg}."
#  end
#  erb :"/people/new"
#end
#end
