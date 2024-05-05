module Mutations
    module Users
        class SignUp < BaseMutation

            type Types::SignupResult, null: false

            argument :name, String, required: true
            argument :email, String, required: true
            argument :password, String, required: true
            argument :password_confirmation, String, required: true

            def resolve(name:, email:, password:, password_confirmation:)
                User.create(
                    name: name,
                    email: email,
                    password: password,
                    password_confirmation: password_confirmation
                )
            end
        end
    end
end