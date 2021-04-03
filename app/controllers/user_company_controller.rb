class UserCompanyController < ApplicationController

    get '/my-companies/all' do
        @user=current_user
        erb :'/user_companies/index'
    end

    get '/my-companies/new' do
        @user=current_user

        erb :'/user_companies/new'
    end

    get '/my-companies/:id' do
        @user=current_user
        @user_company=UserCompany.find(params[:id])

        erb :'/user_companies/show'
    end

    post '/my-companies/new' do
        binding.pry
        user_company = UserCompany.new(params[:user_companies])
        user_company.user = current_user
        user_company.save
        
        title=UserJobTitle.new(name: params[:user][:user_job_title])
        title.user_company_id = user_company.id
        title.user_id = current_user.id
        title.save

        if !user_company.save  || !current_user.save
          redirect "/my-companies/new"
        else
          user_company.save && current_user.save
        end
      redirect '/my-companies/all'
    end

    get '/my-companies/:id/edit' do
        @user=current_user
        @user_company=UserCompany.find(params[:id])
        
        erb :'/user_companies/edit'
    end

    get '/my-companies/:id/delete' do
        UserCompany.find(params[:id]).destroy

        redirect '/my-companies/all'
    end

    patch '/my-companies/:name/edit' do
        user_company=UserCompany.find_by(name: params[:name])
        user_company.update(params[:user_companies])

        title=UserJobTitle.find_or_create_by(name: params[:user][:user_job_title])
        title.user_company_id = user_company.id
        title.user_id = current_user.id 
        title.save

        if title.save && user_company.save
          redirect '/my-companies/all'
        else
          redirect "/my-company/#{user_company.name}/edit"
        end
    end

end