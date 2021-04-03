class UserController < ApplicationController
    layout "main"
    
    get '/users/:slug/all' do
        if logged_in?
            @user=current_user
            erb :'/user/index'
        else
            redirect '/'
        end
    end

    get '/users/:slug/profile' do
        @user=current_user

        erb :'/user/show'
    end

    get '/users/:slug/profile/edit' do
        erb :'user/edit'
    end

    get '/users/:slug/profile/delte' do
        current_user.destroy
        redirect '/delete/all'
    end
end