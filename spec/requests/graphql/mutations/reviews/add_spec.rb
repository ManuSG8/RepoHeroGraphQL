require 'rails_helper'
RSpec.describe "GraphQL, addReview mutation" do
    let!(:repo) { Repo.create!(name: "Repo Hero", url: "https://github.com/repohero/repohero") }

    let!(:user) do
      User.create!(
        email: "test@example.com",
        password: "SecurePassword1",
        name: "Test User",
      )
    end

    query = <<~QUERY
    mutation ($id: ID!, $rating: ReviewRating!, $comment: String!) {
        addReview(input: { repoId: $id, rating: $rating, comment: $comment }) {
            ...on Review {
                id
                rating
            }
            ...on ValidationError {
                errors {
                  fullMessages
                  attributeErrors {
                    attribute
                    errors
                  }
                }
            }
        }
    }
    QUERY

    it "adds a new review" do
      post "/graphql", params: {
        query: query,
        variables: {
          id: repo.id,
          rating: "FIVE_STARS",
          comment: "What a repo!"
        }
      }, headers: {
        Authorization: "Bearer #{Jot.encode({ email: user.email })}"
      }

      expect(response.parsed_body).not_to have_errors
      review = Review.last
      expect(response.parsed_body["data"]).to eq(
        "addReview" => {
          "id" => review.id.to_s,
          "rating" => "FIVE_STARS",
        }
      )
      expect(review.user).to eq(user)
    end

    it "cannot add a review without a comment" do
      post "/graphql", params: {
        query: query,
        variables: {
          id: repo.id,
          rating: "FIVE_STARS",
          comment: ""
        }
      }, headers: {
        Authorization: "Bearer #{Jot.encode({ email: user.email })}"
      }
    
        expect(response.parsed_body).not_to have_errors
        expect(response.parsed_body["data"]).to eq(
          "addReview" => {
            "errors" => {
              "fullMessages" => ["Comment can't be blank"],
              "attributeErrors" => [
                {
                  "attribute" => "comment",
                  "errors" => ["can't be blank"],
                }
              ]
            }
          }
        )
    end
end