# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :add_review, mutation: Mutations::Reviews::Add
    field :update_review, mutation: Mutations::Reviews::Update
    field :delete_review, mutation: Mutations::Reviews::Delete
  end
end
