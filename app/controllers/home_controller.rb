# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    sorted_users = User.joins(:pod_results)
                       .group('users.id')
                       .order('SUM(pod_results.score) DESC')
    service = Users::PrepareStatistics.new(sorted_users)
    service.call

    render :index, locals: { sorted_users:, user_statistics: service.stats }
  end
end
