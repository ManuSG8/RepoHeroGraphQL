operation = <<~GQL
query {
    repo(id:"1"){
        name
    }
}
GQL

result = RepoHeroSchema.execute(operation)
puts JSON.pretty_generate(result)