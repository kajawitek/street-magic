# frozen_string_literal: true

# Create Leagues
current_year = Time.zone.now.year
leagues = [current_year - 2, current_year - 1, current_year].map do |year|
  League.find_or_create_by!(year:)
end

# Create Users
password = 'password'
users = 3.times.map do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  nick = Faker::Internet.username(specifier: 5..8)
  email = "#{first_name.downcase}.#{last_name.downcase}@example.com"

  User.create!(
    email:,
    first_name:,
    last_name:,
    nick:,
    password:,
    password_confirmation: password
  )
end

# Create Pods for each League
leagues.each do |league|
  3.times do |i|
    pod = Pod.new(date: Time.zone.today.change(year: league.year) - i.days, league_id: league.id)

    users_with_places = users.map.with_index(1) do |user, index|
      { user:, place: index }
    end

    total_participants = users_with_places.size
    users_with_places.each do |user_with_place|
      score = total_participants - user_with_place[:place] + 1
      pod.pod_results.build(
        user_id: user_with_place[:user].id,
        place: user_with_place[:place],
        score:
      )
    end

    pod.save!
  end
end
