class Movie < ActiveRecord::Base
	RATINGS = Movie.order("rating").map(&:rating).uniq.sort
	scope :by_ratings, lambda {|ratings| where(rating: ratings) }
end

    # t.string   "title"
    # t.string   "rating"
    # t.text     "description"
    # t.datetime "release_date"
    # t.datetime "created_at"
    # t.datetime "updated_at"