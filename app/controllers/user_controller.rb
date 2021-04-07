class UserController < ApplicationController
    layout "main"
    
    get '/users/:slug/all' do
        if logged_in?
            @user=current_user
            erb :'/user/index'
        else
          flash[:warning]='You must be logged in to view this page. Please log in, or sign up.'
          redirect '/'
        end
    end

    get '/users/:slug/profile' do
        if !logged_in?
          flash[:warning]='You must be logged in to view this page. Please log in, or sign up.'
          redirect '/'
        else
        @user=current_user

        erb :'/user/show'
      end
    end

    get '/users/:slug/profile/edit' do
        if !logged_in?
          flash[:warning]='You must be logged in to view this page. Please log in, or sign up.'
          redirect '/'
        else
        @user=current_user
        erb :'user/edit'
      end
    end

    patch '/users/:slug/profile/edit' do
      if !logged_in?
        flash[:warning]='You must be logged in to view this page. Please log in, or sign up.'
        redirect '/'
      else
        user=User.find_by(slugged_username: params[:slug])
        user.update(params[:user])
        user.slugged_username=user.username.gsub(' ', '-')

        if user.save
          user.save
          flash[:messge]='Successfully updated your profile.'

          redirect "/users/#{user.slugged_username}/profile"
        else
          flash[:warning]='Could not update. Try again.'

          redirect "/users/#{user.slugged_username}/profile"
        end
      end
    end

    get '/users/:slug/profile/delete' do
        if !logged_in?
          flash[:warning]='You must be logged in to view this page. Please log in, or sign up.'
          redirect '/'
        else
        current_user.destroy
        flash[:message]='Account successfully deleted.'
        redirect '/delete/all'
      end
    end
end