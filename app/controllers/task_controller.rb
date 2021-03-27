class TaskController < ApplicationController
    layout "main"

    get '/tasks/all' do 
        @user=current_user
        erb :'/tasks/index'
    end

    get '/tasks/new' do
        @user=current_user
        erb :"/tasks/new"
      end

    post '/tasks/new' do
      task=Task.new(params[:task])
      task.user_company=UserCompany.find_by(name: params[:user_company])
      task.user=current_user
      task.save
      if task.save
          redirect "/users/#{current_user.slugged_username}/all"
      else
          redirect "/tasks/new"
          #insert flash
      end
    end

    get '/tasks/:title' do
        @user=current_user
        @task=Task.find_by(title: params[:title])
        
        erb :'/tasks/edit'
    end

    patch '/tasks/:title/edit' do
        task=Task.find_by(title: params[:title])
        task.update(params[:task])
        task.user_company=UserCompany.find_by(name: params[:user_company]) unless params[:user_company]==nil
        task.save

        binding.pry

        redirect "/users/#{current_user.slugged_username}/all"
    end

    delete '/tasks/:title/delete' do
        Task.find_by(title: params[:title]).destroy

        redirect "/users/#{current_user.slugged_username}/all"
    end


end