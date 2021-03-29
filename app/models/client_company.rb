class ClientCompany < ActiveRecord::Base
    belongs_to :user_company
    belongs_to :client
    has_many :jobs
    has_many :client_job_titles
    has_many :clients, through: :client_job_titles
end