require 'rails_helper'
RSpec.describe "Graphql, repo query, with activity" do
    let!(:repo) { Repo.create!(name: "Repo Hero", url: "https://github.com/repohero/repohero") }
    let!(:user) do
        User.create!(
            email: "test@example.com",
            password: "SecurePassword1",
            name: "Test User",
        )
    end



    before do
        15.times do |i|
            review = repo.reviews.create!(rating: 5, comment: "Review #{i}", user: user)
            like = repo.likes.create!
            repo.activities.create(event: review)
            repo.activities.create(event: like)
        end
    end

    it "retrieves a single repo with a list of activities" do
        query = <<~QUERY
        query ($id: ID!) {
            repo(id: $id) {
                ...on Repo {
                    name
                    activities(first: 2) {
                        nodes {
                            __typename
                            event {
                                ... on Review {
                                    rating
                                    comment
                                }
                                ... on Like {
                                    createdAt
                                }
                            }
                        }
                    }
                }
            }
        }
        QUERY

        post "/graphql", params: { query: query, variables: { id: repo.id } }

        expect(response.parsed_body).not_to have_errors
        expect(response.parsed_body["data"]).to match(
            "repo" => a_hash_including(
                "name" => repo.name,
            )
        )
        activities = response.parsed_body.dig("data", "repo", "activities", "nodes")
        expect(activities.count).to eq(2)
    end
end