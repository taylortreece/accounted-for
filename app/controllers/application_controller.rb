class ApplicationController < Sinatra::Base
    configure do
      set :public_folder, 'public'
      set :views, 'app/views' 
      set :layouts, 'app/views/layouts'
      enable :sessions
      set :session_secret, 'password_security'
      register Sinatra::Flash
    end
  
    get '/' do
      erb :index
    end

    post '/login' do
      user=User.find_by(email: params[:email])

      if user && user.authenticate(params[:password])
        session[user_id]=user.id
        redirect '/user'
      else
        redirect '/'
      end
    end

    get '/signup/user_information' do
      erb :signup
    end

    post '/signup/user_information' do
      user=User.new(params[:user])
      user.slugged_username=user.username.gsub(' ', '-')

      if user.save
        num=params[:number_of_user_companies]
        session[:user_id]=user.id

        redirect "/signup/#{current_user.slugged_username}/user_company/#{num}"
      else
        redirect '/signup/user_information'
      end
    end

    get '/signup/:slugged_username/user_company/:num' do
      @user=current_user
      @number_of_user_companies=params[:num]
      erb :'/user_companies/signup'
    end

    post '/signup/user_company/:id' do
      params[:user_companies].each do |company|
        user_company=UserCompany.new(company)
        user_company.user=current_user
        if !user_company.save 
          redirect "/signup/#{current_user.slugged_username}/user_company/#{params[:user_companies].length}"
        end
      end
      
      redirect '/user/all'
    end

    helpers do 
      def logged_in?
        !!session[:user_id]
      end

      def current_user
        User.find(session[:user_id])
      end
    end

  end