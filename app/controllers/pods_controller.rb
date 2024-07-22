# frozen_string_literal: true

class PodsController < ApplicationController
  def index
    pods = Pod.all

    render :index, locals: { pods: }
  end

  def show
    pod = Pod.find(params[:id])

    render :show, locals: { pod: }
  end

  def new
    pod = Pod.new
    number_of_players = params[:number_of_players].to_i
    number_of_players.times { pod.pod_results.build }

    render :new, locals: { pod: }
  end

  def edit
    pod = Pod.find(params[:id])

    render :edit, locals: { pod: }
  end

  def create # rubocop: disable Metrics/AbcSize
    league = League.find_or_create_by(year: Date.current.year)
    pod = league.pods.new(pod_params)

    pod.pod_results.each do |result|
      result.score = pod.pod_results.size - result.place + 1
    end

    if pod.save
      redirect_to root_path, notice: 'Pod was successfully created. Add results'
    else
      render :new, locals: { pod: }, notice: 'Pod not created.'
    end
  end

  def update # rubocop: disable Metrics/AbcSize
    pod = Pod.find(params[:id])

    if pod.update(pod_params)
      pod.pod_results.each do |result|
        result.score = pod.pod_results.size - result.place + 1
      end
      pod.save

      redirect_to pods_path, notice: 'Pod was successfully updated.'
    else
      render :edit, locals: { pod: }
    end
  end

  private

  def pod_params
    params.require(:pod).permit(:date, pod_results_attributes: %i[id user_id place])
  end
end
