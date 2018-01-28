class ApplicationRecord < ActiveRecord::Base
  require 'paranoia'
  self.abstract_class = true
end
