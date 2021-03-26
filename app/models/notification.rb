class Notification < ActiveRecord::Base
    belongs_to :user
    belongs_to :user_company
    has_many :clients, through: :user_company
    has_many :client_companies, through: :user_companies
end