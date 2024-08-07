# frozen_string_literal: true

RSpec.describe 'Users::PrepareStatistics' do
  it 'prepares statistics for the users' do
    user = create(:user, first_name: 'John', last_name: 'Doe')
    pod_result = create(:pod_result, score: 3, place: 1)
    user.pod_results = [pod_result]
    user.save

    service = Users::PrepareStatistics.new([user])
    expect(service.call).to be true
    stats = service.stats

    expect(stats[user.id]).to eq(
      full_name: 'John Doe',
      total_score: 3,
      number_of_played_games: 1,
      number_of_wins: 1,
      average_points: 3,
      win_rate: 100,
      laplace_succession: 100
    )
  end

  it 'prepares statistics for the users with multiple pod results' do
    user = create(:user, first_name: 'John', last_name: 'Doe')
    pod_result1 = create(:pod_result, score: 3, place: 1)
    pod_result2 = create(:pod_result, score: 1, place: 2)
    user.pod_results = [pod_result1, pod_result2]
    user.save

    service = Users::PrepareStatistics.new([user])
    expect(service.call).to be true
    stats = service.stats

    expect(stats[user.id]).to eq(
                                full_name: 'John Doe',
                                total_score: 4,
                                number_of_played_games: 2,
                                number_of_wins: 1,
                                average_points: 2,
                                win_rate: 50.0,
                                laplace_succession: 66.66666666666666
                              )
  end
end
