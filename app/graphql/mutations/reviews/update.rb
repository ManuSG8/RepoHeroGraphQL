module Mutations
    module Reviews
        class Update < BaseMutation
            graphql_name "UpdateReview"

            type Types::ReviewType

            argument :review_id, ID, required: true
            argument :rating, Types::ReviewRating, required: true
            argument :comment, String, required: true

            def resolve(review_id:, rating:, comment:)
                Review.find(review_id).tap do |review|
                    review.update!(
                        rating: rating,
                        comment: comment
                    )
                end
            end
        end
    end
end