class ClientController < ApplicationController

    get '/clients/all' do
        @user=current_user
        @user_clients = user_clients
        erb :'/clients/index'
    end

    get '/clients/new' do
        @user=current_user

        erb :'/clients/new/new_client'
    end

    post '/clients/new' do
        num=params[:number_of_new_client_companies]

        if Client.find_by(email: params[:client][:email])
          redirect '/clients/index'
        else
        client=Client.new(params[:client])
        client.slugged_name=client.first_name+'-'+client.last_name.gsub(/\s+/, "")

        if client.save
          client.save
          redirect "/clients/companies/#{client.slugged_name}/#{num}"
        else
          redirect '/clients/new'
        end
    end

    get '/clients/:slug/edit' do
      @user=current_user
      @client=Client.find_by(slugged_name: params[:slug])

      erb :'/clients/edit/edit_client'
    end

    get '/clients/companies/:slug/:num' do
        @user=current_user
        @client=Client.find_by(slugged_name: params[:slug])
        @num=params[:num]

        erb :'/clients/new/add_companies'
    end

    post '/client/company/:slug' do
        client=Client.find_by(slugged_name: params[:slug])

        counter=0
      params[:client_companies].each do |company|
        client_company = ClientCompany.new(company)
        client_company.client = client
        client_company.user_company=UserCompany.find_by(name: params[:user_company])
        client_company.save
        
        title=ClientJobTitle.new(name: params[:client]["#{counter}".to_i][:client_job_title])
        title.client_company_id = client_company.id
        title.client_id = client.id
        title.save
        counter+=1

        if !client_company.save  || !client.save
          redirect "/clients/companies/#{client.slugged_name}/#{num}"
        else
          client_company.save && client.save
        end
      end
      redirect "/clients/all"
    end

    patch '/clients/:slug/edit' do
      client=Client.find_by(slugged_name: params[:slug])
      client.update(params[:client])
      num=params[:number_of_new_client_companies]
      
      if client.save
        client.save
        redirect "/client/#{client.slugged_name}/edit/company/#{num}"
      else
        redirect '/client/#{client.slugged_name}/edit'
      end
    end

    get "/client/:slug/edit/company/:num" do
      @user=current_user
      @user_client_companies=user_client_companies
      @client=Client.find_by(slugged_name: params[:slug])
      @num=params[:num]

      erb :'/clients/edit/add_client_companies'
    end

    patch '/client/:slug/edit/company' do
      client=Client.find_by(slugged_name: params[:slug])

      counter=0
    params[:client_companies].each do |company|
      new_client_company = ClientCompany.new(company)
      new_client_company.client = client
      new_client_company.user_company=UserCompany.find_by(name: params[:user_company])
      new_client_company.save
      
      binding.pry
      existing_companies=Clientcompany.find_by(name: params[:current_company[counter]].name) unless params[:current_company] == nil || counter > params[:current_company].length end

      title=ClientJobTitle.new(name: params[:client]["#{counter}".to_i][:client_job_title])
      title.client_company_id = new_client_company.id
      title.client_id = client.id
      title.save
      counter+=1

      if !new_client_company.save  || !client.save
        redirect "/clients/companies/#{client.slugged_name}/#{num}"
      else
        new_client_company.save && client.save
      end
    redirect "/clients/all"
    end
  end


end