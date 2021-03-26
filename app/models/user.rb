class User < ActiveRecord::Base
    has_secure_password
    
    has_many :notifications
    has_many :notes
    has_many :tasks
    has_many :user_companies
    has_many :user_job_titles
    has_many :clients, through: :user_companies
    has_many :client_companies, through: :user_companies
    has_many :jobs, through: :user_companies
    has_many :jobs, through: :client_companies

    validates :email, uniqueness: true
    validates :username, uniqueness: true
  end