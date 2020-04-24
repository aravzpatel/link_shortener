require 'sinatra'
require 'shotgun'
require 'base64'
require 'pstore'

get '/:url' do
    redirect "http://" + ShortURL.read(params[:url])
end

get '/' do
    erb :bear
end

post '/' do
    @url = params[:url]
    p @url
    @url = generate_short_url(params[:url])
    erb :output
    
end

def generate_short_url(original)
    ShortURL.save(Base64.encode64(original)[0..6], original)

    "localhost:4567/" + Base64.encode64(original)[0..6]
end

class ShortURL
    def self.save(encoded, original)
        store.transaction { |t| store[encoded] = original}
    end

    def self.read(encoded)
        store.transaction { store[encoded] }
    end

    def self.store
        @store ||= PStore.new("shortened_urls.db")
    end
        
end