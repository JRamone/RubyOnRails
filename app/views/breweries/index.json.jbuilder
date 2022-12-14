json.array! @breweries do |b|
  json.id b.id
  json.name b.name
  json.year b.year
  json.active b.active
  json.beercount b.beers.count
end
