class Article < ActiveRecord::Base
	belongs_to :user
	has_many :comments, dependent: :destroy
	#has_many :likes, dependent: :destroy 
	acts_as_votable
	validates :title, presence: true

	def up_total
    self.likes.where(like: true).size
  end

  def down_total
    self.likes.where(like: false).size
  end
end

