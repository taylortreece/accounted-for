class ClientController < ApplicationController

    get '/clients/all' do
      if !logged_in?
        flash[:warning]='You must be logged in to view this page. Please log in, or sign up.'
        redirect '/'
      else
        @user=current_user
        @user_clients = user_clients
        erb :'/clients/index'
      end
    end

    get '/clients/new' do
      if !logged_in?
        flash[:warning]='You must be logged in to view this page. Please log in, or sign up.'
        redirect '/'
      else
        @user=current_user

        erb :'/clients/new/new_client'
      end
    end

    post '/clients/new' do
      if !logged_in?
        flash[:warning]='You must be logged in to view this page. Please log in, or sign up.'
        redirect '/'
      else
        num=params[:number_of_new_client_companies]

        if Client.find_by(email: params[:client][:email])
          flash[:warning]='Client email already exists.'
          redirect '/clients/all'
        else
          client=Client.new(params[:client])
          client.slugged_name=client.first_name+'-'+client.last_name.gsub(/\s+/, "")

          if client.save
            flash[:message]="#{client.first_name + ' ' + client.last_name} successfully added to clients!"
            redirect "/clients/companies/#{client.slugged_name}/#{num}"
          else
            flash[:fatal]="Could not add new client."
            redirect '/clients/new'
          end
        end
      end
    end

    get "/clients/companies/:slug/:num" do
      if !logged_in?
        flash[:warning]='You must be logged in to view this page. Please log in, or sign up.'
        redirect '/'
      else
        @user=current_user
        @client=Client.find_by(slugged_name: params[:slug])
        @num=params[:num]

      erb :'/clients/new/add_companies'
      end
    end

    post '/client/company/:slug' do
      if !logged_in?
        flash[:warning]='You must be logged in to view this page. Please log in, or sign up.'
        redirect '/'
      else
        client=Client.find_by(slugged_name: params[:slug])
        counter=0

        if params[:current_companies]!=nil
        params[:current_companies].length.times do
          
        if params[:current_companies]["#{counter}".to_s][:company_name]!=nil
          info=params[:current_companies]["#{counter}".to_s]

            existing_company=ClientCompany.find_by(name: info[:company_name])
            existing_company.client=client
            client.client_companies<<existing_company
            existing_company_title=ClientJobTitle.find_or_create_by(name: info[:titles])
            existing_company_title.client=client
            existing_company_title.client_company=existing_company
            
            if client.save
            existing_company.save
            existing_company_title.save
            else
              flash[:fatal]="New client could not be added."
            end
          end
          counter+=1
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
        counter+1
      end

        if !@client_company.save  || !client.save
          flash[:warning]="#{client.first_name + ' ' + client.last_name} was saved as a client, but something went wrong with the company."
          redirect "/clients/companies/#{client.slugged_name}/#{num}"
        else
          @client_company.save && client.save
          flash[:message]="#{client.first_name + ' ' + client.last_name} and their companies were added!"
  
        end
      end
    end
    redirect "/clients/all"
  end
  
    get '/clients/:slug/edit' do
      if !logged_in?
        flash[:warning]='You must be logged in to view this page. Please log in, or sign up.'
        redirect '/'
      else
        @user=current_user
        @client=Client.find_by(slugged_name: params[:slug])
  
      erb :'/clients/edit/edit_client'
      end
    end

    patch '/clients/:slug/edit' do
      if !logged_in?
        flash[:warning]='You must be logged in to view this page. Please log in, or sign up.'
        redirect '/'
      else
      client=Client.find_by(slugged_name: params[:slug])
       
        if client.update(params[:client])
          num=params[:number_of_new_client_companies]
          client.save

          flash[:message]="#{client.first_name + ' ' + client.last_name}'s information was updated!"
          redirect "/client/#{client.slugged_name}/edit/company/#{num}"
        else
          flash[:fatal]="Could not update #{client.first_name + ' ' + client.last_name}'s information."
          redirect '/client/#{client.slugged_name}/edit'
        end
      end
    end

    get "/client/:slug/edit/company/:num" do
      if !logged_in?
        flash[:warning]='You must be logged in to view this page. Please log in, or sign up.'
        redirect '/'
      else
        @user=current_user
        @user_client_companies=user_client_companies
        @client=Client.find_by(slugged_name: params[:slug])
        @num=params[:num]

      erb :'/clients/edit/add_client_companies'
      end
    end

    patch '/client/:slug/edit/company' do
      if !logged_in?
        flash[:warning]='You must be logged in to view this page. Please log in, or sign up.'
        redirect '/'
      else
        client=Client.find_by(slugged_name: params[:slug])
        counter=0
        titles=[]

        if params[:current_companies]!=nil
        params[:current_companies].length.times do
        if params[:current_companies]["#{counter}".to_s][:company_name]!=nil
          info=params[:current_companies]["#{counter}".to_s]

          existing_company=ClientCompany.find_by(name: info[:company_name])
          existing_company.client=client
          client.client_companies<<existing_company
          existing_company_title=ClientJobTitle.find_or_create_by(name: info[:titles])
          existing_company_title.client=client
          existing_company_title.client_company=existing_company
          
            if client.save
              existing_company.save
              existing_company_title.save

              flash[:message]='Client updated!'
            else
              flash[:fatal]='Could not update client.'
            end
          end
          counter+=1
        end
      end

        if params[:client_companies]!=nil
          counter=0
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
  end

   get '/clients/:slug/remove_company/:company_name' do
    if !logged_in?
        flash[:warning]='You must be logged in to view this page. Please log in, or sign up.'
        redirect '/'
    else
     client=Client.find_by(slugged_name: params[:slug])
     client_company=ClientCompany.find_by(name: params[:company_name])
     
     if client.client_companies.delete(client_company)
      flash[:message]="#{client_company.name} successfully removed from #{client.first_name + ' ' + client.last_name}'s list of companies!"
     else
      flash[:fatal]="Could not remove #{client_company.name} from #{client.first_name + ' ' + client.last_name}'s list of companies."
     end

     redirect '/clients/all'
    end
   end

   get '/clients/:slug/delete' do
     if Client.find_by(slugged_name: params[:slug]).destroy
      flash[:message]='Successfully deleted!'
     else
      flash[:fatal]='Could not delete client.'
     end
     
     redirect '/clients/all'
   end

end