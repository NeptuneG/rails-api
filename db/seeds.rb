# frozen_string_literal: true

%w[Pop Soul R&B Funk Rock Rap Jazz Reggee Electronic].each do |genre|
  Genre.create!(name: genre)
end

LiveHouse.create!(name: 'Billboard Live TOKYO', address: '@Midtown, Roppongi, Tokyo')
