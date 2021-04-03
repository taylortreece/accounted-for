class ClientCompanyController < ApplicationController

    get '/client-companies/all' do
        @user=current_user
        @user_client_companies=user_client_companies
        erb :'/client_companies/index'
    end

    get '/client-companies/new' do
        @user=current_user
        erb :'/client_companies/new'
    end

    post '/client-company/new' do
        params[:client_companies].each do |company|
        client_company = ClientCompany.new(company)
        binding.pry
        client_company.user_company = UserCompany.find_by(name: params[:user_company])
        client_company.save

        if !client_company.save  || !current_user.save
          redirect "/client-companies/new"
        else
          client_company.save && current_user.save
          redirect '/client-companies/all'
        end
      end
    end

    get '/client-companies/:name' do
      @user=current_user
      @client_company=ClientCompany.find_by(name: params[:name])
      erb :'client_companies/show'
    end

    get '/client-companies/:name/edit' do
      @user=current_user
      @client_company=ClientCompany.find_by(name: params[:name])
      erb :'/client_companies/edit'
    end

    get '/client-companies/:name/delete' do
      ClientCompany.find_by(name: params[:name]).destroy

      redirect '/client-companies/all'
    end

    patch '/client-companies/:name/edit' do
      client_company=ClientCompany.find_by(name: params[:name])
        client_company.update(params[:client_companies])
        client_company.user_company = UserCompany.find_by(name: params[:user_company])


        if client_company.save
          client_company.save
          redirect '/client-companies/all'
        else
          redirect "/client-company/#{client_company.name}/edit"
        end
    end


end