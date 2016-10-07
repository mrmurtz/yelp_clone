class Restaurant < ActiveRecord::Base
  has_many :reviews,
    -> { extending WithUserAssociationExtension },
    dependent: :destroy

  belongs_to :user,
      -> { extending WithUserAssociationExtension }
  validates :name, length: { minimum: 3 }, uniqueness: true


  def average_rating
    return 'N/A' if reviews.none?
    # reviews.inject(0) {|memo, review| memo + review.rating} / reviews.length
    reviews.average(:rating)
  end
end
