class UserJobTitle < ActiveRecord::Base
    belongs_to :user
    belongs_to :user_company
end