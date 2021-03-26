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

end