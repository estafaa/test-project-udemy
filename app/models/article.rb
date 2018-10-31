class Article < ActiveRecord::Base
   searchkick
  
   extend FriendlyId
   friendly_id :slug_candidates, use: :history
   
   belongs_to :user
   has_many :article_categories
   has_many :categories, through: :article_categories
   validates :title, presence: true, length: {minimum:3, maximum: 50}
   validates :description, presence: true, length: {minimum:10, maximum: 500}
   validates :user_id, presence: true
   
   
   def slug_candidates
     [
       :title,
       [:title, :user_id]
     ]
   end
    
end

