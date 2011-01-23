class Option
  include MongoMapper::EmbeddedDocument
  
  belongs_to :poll
  
  key :image
  key :title
  
end