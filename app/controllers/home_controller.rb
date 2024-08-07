# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    sorted_users = User.joins(:pod_results)
                       .group('users.id')
                       .order('SUM(pod_results.score) DESC')
    user_statistics = prepare_user_statistics(sorted_users)

    render :index, locals: { sorted_users:, user_statistics: }
  end

  private

  def prepare_user_statistics(users) # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
    users.each_with_object({}) do |user, stats|
      results = user.pod_results
      total_score = results.sum(:score)
      number_of_played_games = results.size
      number_of_wins = results.where(place: 1).count

      stats[user.id] = {
        full_name: user.full_name,
        total_score:,
        number_of_played_games:,
        number_of_wins:,
        average_points: number_of_played_games.zero? ? 0 : total_score / number_of_played_games.to_f,
        win_rate: number_of_played_games.zero? ? 0 : (number_of_wins / number_of_played_games.to_f) * 100,
        laplace_succession: (number_of_wins + 1) / (number_of_played_games.to_f + 1) * 100
      }
    end
  end
end
