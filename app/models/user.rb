class User < ActiveRecord::Base
  has_secure_password
  has_many :rides
  has_many :attractions, through: :rides

  before_create :set_mood 

  def set_mood
  	self.nausea = 0 if self.nausea.nil? 
  	self.happiness = 0 if self.happiness.nil? 
  end

  def mood
  	(self.nausea > self.happiness) ? "sad" : "happy"
  end
end
