require 'sinatra'

get '/:url' do
    "URL is #{params[:url]}"
end

get '/' do
    "Enter your URL"
end

post '/' do
    "New URL added: #{params[:url]}\n"
end