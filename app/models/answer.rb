class Answer < ActiveRecord::Base
  attr_accessible :text, :question_id
  validates_presence_of :text, :question_id, :responder_id

  belongs_to :responder, class_name: "User"
  belongs_to :question
  has_many :votes, as: :votable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  def vote_count
    self.upvotes - self.downvotes
  end

  def upvotes
    self.votes.where("value = ?", 1).count
  end

  def downvotes
    self.votes.where("value = ?", -1).count
  end
end
