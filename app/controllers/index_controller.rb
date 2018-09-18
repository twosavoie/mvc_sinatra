#require 'sinatra' #not in sk answer code

get '/:birthdate' do
  setup_index_view
end

# print the numerology message
get '/message/:birth_path_num' do
  birth_path_num = params[:birth_path_num].to_i
  @message = Person.get_message(birth_path_num)
  erb :index
end

# when page loads, get & print the form
get '/' do
  erb :form
end

# After checking for valid input redirect to print numerology message. If the input is invalid, print an error message. Also use redirect to prevent user from inputing the same info repeatedly
post '/' do
#  birthdate = params[:birthdate].gsub("-","")
  birthdate = params[:birthdate].tr("/-", "") #This allows ""-/ in /
  if Person.valid_birthdate(birthdate)
    birth_path_num = Person.get_birth_path_num(birthdate)
    redirect "/message/#{birth_path_num}"
  else
    @error = "You should enter a valid birthdate in the form of mmddyyyy."
    erb :form
  end
end

def setup_index_view
	birthdate = params[:birthdate]
	birth_path_num = Person.get_birth_path_num(birthdate)
	@message = Person.get_message(birth_path_num)
  erb :index
end

# not necessary to script(form). allowed url localhost:4567/birthdate entered by user. however, testing does not work unless it is included.
#get '/:birthdate' do #not in SK answer code
#  birthdate = params[:birthdate]
#  birth_path_num = Person.get_birth_path_num(birthdate)
#  @message = get_message(birth_path_num)
#  erb :index
#end #this code exists in SK answer code as method setup_index_view but I'm sure this was changed to this code while working on the numerology app. I'll use whichever the test was written for.


# not necessary to script. replaced by setup_index_view method. this works though
#post '/' do
#  birthdate = params[:birthdate]
#  birth_path_num = get_birth_path_num(birthdate)
#  @message = get_message(birth_path_num)
#  "#{@message}"
#end

# not necessary to script. just creating a second page
#get '/newpage' do # why not '/:newpage' ?
  # contents of your new page
#  erb :newpage
#end

# not necessary, function replaced, works though
#def setup_index_view
#  birthdate = params[:birthdate]
#  birth_path_num = get_birth_path_num(birthdate)
#  @message = get_message(birth_path_num)
#  "#{@message}"
#end
#post '/' do
#  setup_index_view
#end
