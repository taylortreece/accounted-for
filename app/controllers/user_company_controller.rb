class UserCompanyController < ApplicationController

    get '/my-companies/all' do
      if !logged_in?
        flash[:warning]='You must be logged in to view this page. Please log in, or sign up.'
        redirect '/'
      else
        @user=current_user
        erb :'/user_companies/index'
      end
    end

    get '/my-companies/new' do
      if !logged_in?
        flash[:warning]='You must be logged in to view this page. Please log in, or sign up.'
        redirect '/'
      else
        @user=current_user

        erb :'/user_companies/new'
      end
    end

    get '/my-companies/:id' do
      if !logged_in?
        flash[:warning]='You must be logged in to view this page. Please log in, or sign up.'
        redirect '/'
      else
        @user=current_user
        @user_company=UserCompany.find(params[:id])

        erb :'/user_companies/show'
      end
    end

    post '/my-companies/new' do
      if !logged_in?
        flash[:warning]='You must be logged in to view this page. Please log in, or sign up.'
        redirect '/'
      else
        user_company = UserCompany.new(params[:user_companies])
        user_company.user = current_user
        user_company.save
        
        title=UserJobTitle.new(name: params[:user][:user_job_title])
        title.user_company_id = user_company.id
        title.user_id = current_user.id
        title.save

        if !user_company.save  || !current_user.save
          flash[:fatal]="Could not create new company. Try again."
          redirect "/my-companies/new"
        else
          user_company.save && current_user.save
          flash[:message]="#{user_company.name} successfully created!"
        end
      redirect '/my-companies/all'
      end
    end

    get '/my-companies/:id/edit' do
      if !logged_in?
        flash[:warning]='You must be logged in to view this page. Please log in, or sign up.'
        redirect '/'
      else
        @user=current_user
        @user_company=UserCompany.find(params[:id])
        
        erb :'/user_companies/edit'
      end
    end

    get '/my-companies/:id/delete' do
        if UserCompany.find(params[:id]).destroy
        flash[:message]="Successfully deleted!"
        else
        flash[:fatal]="Could not delete company."
        end
        redirect '/my-companies/all'
    end

    patch '/my-companies/:name/edit' do
      if !logged_in?
        flash[:warning]='You must be logged in to view this page. Please log in, or sign up.'
        redirect '/'
      else
        user_company=UserCompany.find_by(name: params[:name])
        user_company.update(params[:user_companies])

        title=UserJobTitle.find_or_create_by(name: params[:user][:user_job_title])
        title.user_company_id = user_company.id
        title.user_id = current_user.id 
        title.save

        if title.save && user_company.save
          flash[:message]="#{user_company.name} successfully updated."
          redirect '/my-companies/all'
        else
          flash[:fatal]="Could not update #{user_company.name}. Try again."
          redirect "/my-company/#{user_company.name}/edit"
        end
      end
    end

end