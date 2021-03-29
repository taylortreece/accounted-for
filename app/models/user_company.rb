class UserCompany < ActiveRecord::Base
    belongs_to :user
    has_many :tasks
    has_many :notes
    has_many :jobs
    has_many :user_job_titles
    has_many :client_companies
    has_many :clients, through: :client_companies
    has_many :jobs, through: :client_companies
    has_many :users, through: :user_job_titles
end