enable :sessions

callback_url = "http://localhost:9393/oauth/callback"

get "/" do
  '<a href="/oauth/connect">Connect with Instagram</a>'
end

get "/oauth/connect" do
  redirect Instagram.authorize_url(:redirect_uri => callback_url)
end

get "/oauth/callback" do
  response = Instagram.get_access_token(params[:code], :redirect_uri => callback_url)
  session[:access_token] = response.access_token
  redirect "/recent"
end

get "/feed" do
  client = Instagram.client(:access_token => session[:access_token])
  user = client.user

  html = "<h1>#{user.username}'s recent photos</h1>"
  for media_item in client.user_recent_media
    html << "<img src='#{media_item.images.thumbnail.url}'>"
  end
  html
end

get '/filter' do
  @grams = Gram.new.fetch_instagrams!
  @filters = grams.map(&:filter).compact!
  p @filters
  erb :filter
end

get '/geo' do
  @grams = User.find_or_create_by_username(params[:username])
  @grams.fetch_instagrams!
  @geos = grams.map(&:location).compact!
  p @geo
  erb :geo
end

get '/recent' do
 @ = User.find_or_create_by_username(params[:username])
 @gram.fetch_instagrams!
 @recent = grams.users.map(&:created_at).compact!
 p @recent
 erb :index
end



