class TaskController < ApplicationController

    get '/tasks/new' do
        @user=current_user
        erb :"/tasks/new"
      end

    post '/tasks/new' do
      binding.pry
      task=Task.new(params[:task])
      task.user_company=UserCompany.find_by(name: params[:user_company])
      task.user=current_user
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
        binding.pry
    end

end