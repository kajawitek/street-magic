# frozen_string_literal: true

module Users
  class PrepareStatistics
    attr_reader :stats

    def initialize(users)
      @users = users
      @stats = {}
    end

    def call
      @users.each_with_object(@stats) do |user, stats|
        stats[user.id] = prepare_statistics(user)
      end
      true
    end

    private

    def prepare_statistics(user)
      {
        full_name: user.full_name,
        total_score: total_score(user),
        number_of_played_games: user.pod_results.size,
        number_of_wins: number_of_wins(user),
        average_points: average_points(user),
        win_rate: win_rate(user),
        laplace_succession: laplace_succession(user)
      }
    end

    def total_score(user)
      user.pod_results.sum(:score)
    end

    def number_of_played_games(user)
      user.pod_results.size
    end

    def number_of_wins(user)
      user.pod_results.where(place: 1).count
    end

    def average_points(user)
      total_score = total_score(user)
      number_of_played_games = number_of_played_games(user)
      return 0 if number_of_played_games.zero?

      total_score / number_of_played_games.to_f
    end

    def win_rate(user)
      number_of_wins = number_of_wins(user)
      number_of_played_games = number_of_played_games(user)
      return 0 if number_of_played_games.zero?

      (number_of_wins / number_of_played_games.to_f) * 100
    end

    def laplace_succession(user)
      number_of_wins = number_of_wins(user)
      number_of_played_games = number_of_played_games(user)
      ((number_of_wins + 1) / (number_of_played_games.to_f + 1)) * 100
    end
  end
end
