# frozen_string_literal: true

module Types
  class RepoType < Types::BaseObject
    field :id, ID, null: false
    field :name, String
    field :url, String
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :categories, [CategoryType], null: false

    field :name_reversed, String, null: false, complexity: 100 # Esto indica que va a sumar +10 al complexity, no 1 como es por defecto. Ejemplo:
    # query {
    #   repo(id: 1) { +1
    #     name +1
    #     url +1
    #     nameReversed +10
    #   }
    # } TOTAL: 13 puntos

    def name_reversed
      object.name.reverse
    end
  end
end
