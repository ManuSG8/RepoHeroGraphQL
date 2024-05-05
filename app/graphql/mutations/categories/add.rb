module Mutations
    module Categories
        class Add < BaseMutation
            type Types::CategoryType, null: false

            argument :name, String, required: true

            def resolve(name:)
                Category.create!(name: name)
            end
        end
    end
end