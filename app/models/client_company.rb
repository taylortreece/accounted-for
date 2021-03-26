class ClientCompany < ActiveRecord::Base
    belongs_to :user_company
    belongs_to :client
    has_many :jobs
end