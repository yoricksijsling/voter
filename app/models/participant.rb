class Participant
  include MongoMapper::EmbeddedDocument
  
  belongs_to :poll
  
  key :code
  key :votes_for, Set, :typecast => 'ObjectId'
  key :votes_against, Set, :typecast => 'ObjectId'
  
end