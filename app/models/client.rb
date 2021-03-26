class Client < ActiveRecord::Base
    has_many :client_companies
    has_many :job_titles
    has_many :user_companies, through: :client_companies
    has_many :jobs, through: :client_companies
    has_many :jobs, through: :user_companies
end