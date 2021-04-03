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
          redirect '/clients/all'
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
    end

    get "/clients/companies/:slug/:num" do
      @user=current_user
      @client=Client.find_by(slugged_name: params[:slug])
      @num=params[:num]

      erb :'/clients/new/add_companies'
    end

    get '/clients/:slug/edit' do
      @user=current_user
      @client=Client.find_by(slugged_name: params[:slug])

      erb :'/clients/edit/edit_client'
    end

    post '/client/company/:slug' do
        client=Client.find_by(slugged_name: params[:slug])

        params[:current_companies].each do |info|
          if !info[:titles].blank? 
            existing_company=ClientCompany.find_by(name: info[:company_name])
            existing_company.client=client
            existing_company_title=ClientJobTitle.find_or_create_by(name: info[:titles])
            existing_company_title.client=client
            existing_company_title.client_company=existing_company
            client.save
            existing_company.save
            existing_company_title.save
          end
        end

        if !params[:client_companies].nil?
        counter=0
      params[:client_companies].each do |company|
        @client_company = ClientCompany.new(company)
        @client_company.client = client
        @client_company.user_company=UserCompany.find_by(name: params[:user_company])
        @client_company.save
        
        title=ClientJobTitle.new(name: params[:client]["#{counter}".to_i][:client_job_title])
        title.client_company_id = @client_company.id
        title.client_id = client.id
        title.save
        counter+=1
      end
      binding.pry
        if !@client_company.save  || !client.save
          redirect "/clients/companies/#{client.slugged_name}/#{num}"
        else
          @client_company.save && client.save
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
      titles=[]

      if params[:current_companies]!=nil
      params[:current_companies].each do |info|
        if !info[:titles].blank?
          existing_company=ClientCompany.find_by(name: info[:company_name])
          existing_company.client=client
          existing_company_title=ClientJobTitle.find_or_create_by(name: info[:titles])
          existing_company_title.client=client
          existing_company_title.client_company=existing_company
          client.save
          existing_company.save
          existing_company_title.save
          end
        end
      end

        if params[:client_companies]!=nil
        params[:client_companies].each do |company|
        new_client_company = ClientCompany.new(company)
        new_client_company.client = client
        new_client_company.user_company=UserCompany.find_by(name: params[:user_company])
        new_client_company.save

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
       end
     end
     redirect "/clients/all"
   end

   get '/clients/:slug/remove_company/:company_name' do
     client=Client.find_by(slugged_name: params[:slug])
     client_company=ClientCompany.find_by(name: params[:company_name])
     client.client_companies.delete(client_company)

     redirect '/clients/all'
   end

end