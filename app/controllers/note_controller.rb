class NoteController < ApplicationController

    get '/notes/new' do 
        if logged_in?
          @user=current_user
          erb :'/notes/new'
        else
            redirect '/'
        end
    end

    post '/notes/new' do
        note=Note.new(params[:note])
        note.user_company=UserCompany.find_by(name: params[:user_company])
        note.user=current_user
        if note.save
            redirect "/users/#{current_user.slugged_username}/all"
        else
            redirect "/notes/new"
            #insert flash
        end
    end

    get 'notes/:title' do
        @user=current_user
        @note=Note.find_by(title: params[:title])
        
        erb :'/note/edit'
    end

end