class Restaurant < ActiveRecord::Base

  has_attached_file :image, :styles => {  medium: "300x300>", thumb: "200x200#" }, :default_url => "poppadom.jpg"

  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  has_many :reviews, dependent: :destroy
  belongs_to :user
  validates :name, length: {minimum: 3}, uniqueness: true

  def create_review(user, params)
    new_review = reviews.build(params)
    new_review.user = user
    new_review.save
    new_review
  end

  def average_rating
    return 'N/A' if reviews.none?
    reviews.average(:rating)
  end
end
