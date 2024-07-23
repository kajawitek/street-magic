# frozen_string_literal: true

# Create Leagues
leagues = [2022, 2023, 2024].map do |year|
  League.find_or_create_by!(year:)
end

# Create Users
users = [
  { email: 'michael.scott@dm.com', first_name: 'Michael', last_name: 'Scott', nick: 'mic', password: 'password',
    password_confirmation: 'password' },
  { email: 'jim.halpert@dm.com', first_name: 'Jim', last_name: 'Halpert', nick: 'jimmy', password: 'password',
    password_confirmation: 'password' },
  { email: 'tim.scott@dm.com', first_name: 'Tim', last_name: 'Scott', nick: 'timmy', password: 'password',
    password_confirmation: 'password' }
].map do |user_attrs|
  User.create!(user_attrs)
end

# Create Pods for each League
leagues.each_with_index do |league, _index|
  3.times do |i|
    pod = Pod.find_or_create_by!(date: Time.zone.today - i.days, league_id: league.id)

    users_with_places = users.map.with_index(1) do |user, index|
      { user:, place: index }
    end

    total_participants = users_with_places.size
    users_with_places.each do |user_with_place|
      score = total_participants - user_with_place[:place] + 1
      PodResult.find_or_create_by!(
        user_id: user_with_place[:user].id,
        pod_id: pod.id,
        place: user_with_place[:place],
        score:
      )
    end
  end
end

Rails.logger.debug 'Seeds created successfully.'
