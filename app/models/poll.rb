class Poll
  include MongoMapper::Document
  
  key :title
  key :description
  
  many :options
  many :participants
  
  def get_participant(code)
    self.participants.select{ |p| p.code == code }.first
  end
  
  def options_csv # yeah yeah not really csv i know
    self.options.map{|o| o.title }.join ','
  end
  def options_csv=(titles)
    throw :burp if self.options.any?
    titles.split(',').each do |title|
      self.options << Option.new(:title => title)
    end
  end
  
  def participant_count
    self.participants.count
  end
  def participant_count=(count)
    throw :burp if self.participants.any?
    (0..(count-1)).map do |i|
      self.participants << Participant.new(:code => rand(1000000).to_s)
    end
  end
  
end