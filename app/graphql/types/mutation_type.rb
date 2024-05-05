# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :add_review, mutation: Mutations::Reviews::Add
  end
end
