class UserController < ApplicationController
    layout "main"
    
    get '/user/all' do
        @user=current_user
        erb :'/user/index'
    end

end