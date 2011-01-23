class Poll
  include MongoMapper::Document
  
  key :title
  key :description
  
  many :options
  many :participants
  
  def get_participant(code)
    self.participants.select{ |p| p.code == code }.first
  end
  
end