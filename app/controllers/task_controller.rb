class TaskController < ApplicationController

    get '/tasks/all' do 
        if !logged_in?
          flash[:warning]='You must be logged in to view this page. Please log in, or sign up.'
          redirect '/'
        else
          @user=current_user
          erb :'/tasks/index'
        end
    end

    get '/tasks/new' do
        if !logged_in?
          flash[:warning]='You must be logged in to view this page. Please log in, or sign up.'
          redirect '/'
        else
          @user=current_user
          erb :"/tasks/new"
        end
    end

    post '/tasks/new' do
        if !logged_in?
          flash[:warning]='You must be logged in to view this page. Please log in, or sign up.'
          redirect '/'
        else
          task=Task.new(params[:task])
          task.user_company=UserCompany.find_by(name: params[:user_company])
          task.user=current_user

           if task.save
             flash[:message]="#{task.title} successfully created!"
             redirect "/users/#{current_user.slugged_username}/all"
           else
             flash[:fatal]="Could not create new company. Try again."
             redirect "/tasks/new"
           end
        end
    end

    get '/tasks/:title' do
        if !logged_in?
          flash[:warning]='You must be logged in to view this page. Please log in, or sign up.'
          redirect '/'
        else
          @user=current_user
          @task=Task.find_by(title: params[:title])
        
        erb :'/tasks/edit'
      end
    end

    patch '/tasks/:title/edit' do
        if !logged_in?
          flash[:warning]='You must be logged in to view this page. Please log in, or sign up.'
          redirect '/'
        else
          task=Task.find_by(title: params[:title])

          if task.update(params[:task])
            task.user_company=UserCompany.find_by(name: params[:user_company]) unless params[:user_company]==nil       
            task.save
            flash[:message]="#{task.title} successfully updated!"
          else
            flash[:fatal]="Could not update #{task.title}. Try again."
          end

        redirect "/users/#{current_user.slugged_username}/all"
      end
    end

    delete '/tasks/:title/delete' do
        if !logged_in?
          flash[:warning]='You must be logged in to view this page. Please log in, or sign up.'
          redirect '/'
        else
          
          if Task.find_by(title: params[:title]).destroy
            flash[:message]='Successfully deleted!'
          else
            flash[:fatal]='Could not delete task.'
          end

        redirect "/users/#{current_user.slugged_username}/all"
      end
    end

    get '/tasks/:title/delete' do
        if !logged_in?
          flash[:warning]='You must be logged in to view this page. Please log in, or sign up.'
          redirect '/'
        else
          Task.find_by(title: params[:title]).destroy

          if Task.find_by(title: params[:title]).destroy
            flash[:message]='Successfully deleted!'
          else
            flash[:fatal]='Could not delete task.'
          end

        redirect "/users/#{current_user.slugged_username}/all"
      end
    end

end