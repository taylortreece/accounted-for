class NoteController < ApplicationController
    layout :"/app/views/layouts/main.html.erb"

    get '/notes/all' do
        if !logged_in?
          flash[:warning]='You must be logged in to view this page. Please log in, or sign up.'
          redirect '/'
        else
          @user=current_user
          erb :'/notes/index'
      end
    end

    get '/notes/new' do 
        if logged_in?
          @user=current_user
          erb :'/notes/new'
        else
          flash[:warning]='You must be logged in to view this page. Please log in, or sign up.'
          redirect '/'
        end
      end

    post '/notes/new' do
        if !logged_in?
          flash[:warning]='You must be logged in to view this page. Please log in, or sign up.'
          redirect '/'
        else  
          note=Note.new(params[:note])
          note.user_company=UserCompany.find_by(name: params[:user_company])
          note.user=current_user

          if note.save
            flash[:message]="#{note.title} successfully created!"
            redirect "/users/#{current_user.slugged_username}/all"
          else
            flash[:fatal]="Could not create new company. Try again."
            redirect "/notes/new"
          end
       end
    end

    get '/notes/:title' do
        if !logged_in?
          flash[:warning]='You must be logged in to view this page. Please log in, or sign up.'
          redirect '/'
        else
          @user=current_user
          @note=Note.find_by(title: params[:title])
        
        erb :'/notes/edit'
      end
    end

    patch '/notes/:title/edit' do
        if !logged_in?
          flash[:warning]='You must be logged in to view this page. Please log in, or sign up.'
          redirect '/'
        else  
          note=Note.find_by(title: params[:title])

          if note.update(params[:note])
            note.user_company=UserCompany.find_by(name: params[:user_company]) unless params[:user_company]==nil 
            note.save
            flash[:message]="#{note.title} updated!"
          else
            flash[:fatal]="Could not update #{note.title}"
          end

        redirect "/users/#{current_user.slugged_username}/all"
      end
    end

    delete '/notes/:title/delete' do
        if !logged_in?
          flash[:warning]='You must be logged in to view this page. Please log in, or sign up.'
          redirect '/'
        else
  
          if Note.find_by(title: params[:title]).destroy
            flash[:message]='Successfully deleted!'
          else
            flash[:fatal]='Could not delete note.'
          end

        redirect "/users/#{current_user.slugged_username}/all"
      end
    end

    get '/notes/:title/delete' do
        if !logged_in?
          flash[:warning]='You must be logged in to view this page. Please log in, or sign up.'
          redirect '/'
        else  
        
          if Note.find_by(title: params[:title]).destroy
            flash[:message]='Successfully deleted!'
          else
            flash[:fatal]='Could not delete note.'
          end

        redirect "/users/#{current_user.slugged_username}/all"
      end
    end
end