module Types
    class ReviewType < Types::BaseObject
        field :id, ID, null: false
        field :rating, Types::ReviewRating, null: false
        field :comment, String, null: false
    end
end