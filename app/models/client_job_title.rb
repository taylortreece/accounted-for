class ClientJobTitle < ActiveRecord::Base
    belongs_to :client
    belongs_to :client_company
end