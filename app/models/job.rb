class Job < ActiveRecord::Base
    belongs_to :client_company
    belongs_to :user_company
end