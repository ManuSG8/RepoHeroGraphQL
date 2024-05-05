module Types
    class AuthenticatedUserType < BaseObject
        field :email, String, null: true
        field :token, String, null: true

        def token
            "abc123"
        end
    end
end