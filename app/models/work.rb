class Work < ApplicationRecord
  has_many :votes
  has_many :users
  
  def self.spotlight
    works = self.all 
    return works.max_by { |work| work.votes.length }
  end
  
  def self.top_ten(category)
    works = self.all
    top_ten = Work.where(category: category)
    return top_ten.max_by(10) {|work| work.votes.length}
  end

  def self.most_votes(category)
    most_voted = Work.where(category: category).sort_by { |work| -work.votes.length }
    return most_voted
  end
end