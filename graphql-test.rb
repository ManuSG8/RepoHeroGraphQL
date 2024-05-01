operation = <<~GQL
query {
    category(id: "1") {
        name
        repos {
            name
            url
        }
    }
}
GQL

result = RepoHeroSchema.execute(operation)
puts JSON.pretty_generate(result)