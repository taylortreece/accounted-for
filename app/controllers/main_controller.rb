class UserController < ApplicationController
    layout "main"
    
    get '/user/all' do
        erb :'/user/index'
    end

end