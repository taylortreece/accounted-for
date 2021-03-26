class UserCompany < ActiveRecord::Base
    belongs_to :user
    has_many :jobs
    has_many :client_companies
    has_many :clients, through: :client_companies
    has_many :jobs, through: :client_companies
end