# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :node, Types::NodeType, null: true, description: "Fetches an object given its ID." do
      argument :id, ID, required: true, description: "ID of the object."
    end

    def node(id:)
      context.schema.object_from_id(id, context)
    end

    field :nodes, [Types::NodeType, null: true], null: true, description: "Fetches a list of objects given a list of IDs." do
      argument :ids, [ID], required: true, description: "IDs of the objects."
    end

    def nodes(ids:)
      ids.map { |id| context.schema.object_from_id(id, context) }
    end

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :repos, [RepoType], null: false

    field :repo, RepoResultType, null: false do
      argument :id, ID, required: true
    end

    field :category, CategoryType, null: false do
      argument :id, ID, required: true
    end

    field :me, AuthenticatedUserType, null: true

    def repos
      Repo.all
    end

    def repo(id:)
      Repo.find_by(id: id) || { message: "Could not find a repository with id='#{id}'" }
    end

    def category(id:)
      Category.find(id)
    end

    def me
      context[:current_user]
    end
    
  end
end
