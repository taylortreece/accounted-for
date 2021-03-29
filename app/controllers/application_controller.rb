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
        session[:user_id]=user.id
        redirect "/users/#{current_user.slugged_username}/all"
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
      counter=0
      params[:user_companies].each do |company|
        user_company = UserCompany.new(company)
        user_company.user = current_user
        user_company.save
        
        title=UserJobTitle.new(name: params[:user]["#{counter}".to_i][:user_job_title])
        title.user_company_id = user_company.id
        title.user_id = current_user.id
        title.save
        counter+=1

        if !user_company.save  || !current_user.save
          redirect "/signup/#{current_user.slugged_username}/user_company/#{params[:user_companies].length}"
        else
          user_company.save && current_user.save
        end
      end
      
      redirect "/users/#{current_user.slugged_username}/all"
    end

    get '/logout' do
      log_out
      redirect '/'
    end

    helpers do 
      def logged_in?
        !!session[:user_id]
      end

      def current_user
        User.find(session[:user_id])
      end

      def log_out
        session.clear
      end

      def user_clients
        clients=[]
        current_user.user_companies.each do |c|
          c.client_companies.each do |c|
            c.clients.each {|c| clients << c unless clients.include?(c)}
          end
        end
        clients
      end

      def user_client_companies
        client_companies=[]
        current_user.user_companies.each do |c|
          c.client_companies.each {|c| client_companies << c unless client_companies.include?(c)}
          end
        client_companies
      end

    end

    # DELETE METHODS BELOW AFTER TESTING #

    get '/delete/:section' do

      case params[:section]
      when 'users'
        User.all.each do |t|
            t.destroy
        end
      when 'user_companies'
        UserCompany.all.each do |t|
            t.destroy
        end
      when 'notes'
        Note.all.each do |t|
          t.destroy
        end
      when 'tasks'
        Task.all.each do |t|
          t.destroy
        end
      when 'clients'
        Client.all.each do |t|
          t.destroy
        end
      when 'client_companies'
        ClientCompany.all.each do |t|
          t.destroy
        end
      when 'all'
        User.all.each do |t|
          t.destroy
        end
        UserCompany.all.each do |t|
          t.destroy
        end
        Note.all.each do |t|
          t.destroy
        end
        Task.all.each do |t|
          t.destroy
        end
      end
      "#{params[:section]} cleared"
  end

  end