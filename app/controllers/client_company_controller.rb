class ClientCompanyController < ApplicationController

  get '/client-companies/all' do
    if !logged_in?
      flash[:warning]='You must be logged in to view this page. Please log in, or sign up.'
      redirect '/'
    else
      @user=current_user
      @user_client_companies=user_client_companies
      erb :'/client_companies/index'
    end
  end

  get '/client-companies/new' do
    if !logged_in?
      flash[:warning]='You must be logged in to view this page. Please log in, or sign up.'
      redirect '/'
    else
      @user=current_user
      erb :'/client_companies/new'
    end
  end

  post '/client-company/new' do
    if !logged_in?
      flash[:warning]='You must be logged in to view this page. Please log in, or sign up.'
      redirect '/'
    else
      params[:client_companies].each do |company|
      client_company = ClientCompany.new(company)
      client_company.user_company = UserCompany.find_by(name: params[:user_company])
      client_company.save

      if !client_company.save  || !current_user.save
        flash[:fatal]='Could not add company.'
        redirect "/client-companies/new"
      else
        client_company.save && current_user.save
        flash[:message]="#{client_company.name} successfully created!"
        redirect '/client-companies/all'
      end
     end
   end
  end

   get '/client-companies/:name' do
     if !logged_in?
       flash[:warning]='You must be logged in to view this page. Please log in, or sign up.'
       redirect '/'
     else
     @user=current_user
     @client_company=ClientCompany.find_by(name: params[:name])
     erb :'client_companies/show'
     end
   end

  get '/client-companies/:name/edit' do
    if !logged_in?
      flash[:warning]='You must be logged in to view this page. Please log in, or sign up.'
      redirect '/'
    else
    @user=current_user
    @client_company=ClientCompany.find_by(name: params[:name])
    erb :'/client_companies/edit'
    end
  end

  get '/client-companies/:name/delete' do
    if !logged_in?
      flash[:warning]='You must be logged in to view this page. Please log in, or sign up.'
      redirect '/'
    else
     if ClientCompany.find_by(name: params[:name]).destroy
      flash[:message]='Successfully deleted!'
     else
      flash[:fatal]='Could not delete company.'
     end

    redirect '/client-companies/all'
    end
  end

  patch '/client-companies/:name/edit' do
    if !logged_in?
      redirect '/'
    else
    client_company=ClientCompany.find_by(name: params[:name])

      if client_company.update(params[:client_companies])
        client_company.user_company = UserCompany.find_by(name: params[:user_company])
        client_company.save
        flash[:message]="#{client_company.name} successfully updated!"
  
         redirect '/client-companies/all'
       else
         flash[:fatal]="Could not update #{client_company.name}."
       end

      redirect "/client-company/#{client_company.name}/edit"
    end
  end

end