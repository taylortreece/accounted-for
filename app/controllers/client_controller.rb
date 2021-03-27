class ClientController < ApplicationController

    get '/clients/all' do
        @user=current_user
        erb :'/clients/index'
    end

    get '/clients/new' do
        @user=current_user
        erb :'/clients/new/new_client'
    end

    post '/clients/new' do
        num=params[:number_of_new_client_companies]

        client=Client.new(params[:client])
        client.slugged_name=client.first_name+'-'+client.last_name.gsub(/\s+/, "")
        if client.save
          client.save
          redirect "/clients/companies/#{client.slugged_name}/#{num}"
        else
          redirect '/clients/new'
          flash[:error]='something messed up bruv'
        end
    end

    get '/clients/companies/:slug/:num' do
        @user=current_user
        @num=params[:num]
        @client=Client.find_by(slugged_name: params[:slug])
        erb :'/clients/new/add_companies'
    end

end