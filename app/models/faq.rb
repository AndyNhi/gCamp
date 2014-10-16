class Faq

  @@collector = []

  attr_accessor :question, :answer

  def initialize(question,answer)
    self.question = question
    self.answer = answer
    @@collector << self
  end

  def self.all
    @@collector
  end

end
