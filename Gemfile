source "https://rubygems.org"

group :integration do
  # Circle CI uses LXC which doesn't support `docker exec`
  # which is faster then the previous method they used
  # yet building is the wait anyway
  gem "specinfra", "2.12.7"

  gem "serverspec"
  gem "docker"
  gem "rspec"
  gem "docker-api", require: "docker"
end
