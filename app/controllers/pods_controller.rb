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

  def create
    league = League.find_or_create_by(year: Time.zone.now.year)
    pod = league.pods.new(pod_params)
    Pods::CalculateResults.new(pod).call

    if pod.save
      redirect_to pod, notice: 'Pod was successfully created. Add results'
    else
      render :new, status: :unprocessable_entity, locals: { pod: }
    end
  end

  def update
    pod = Pod.find(params[:id])

    if pod.update(pod_params)
      Pods::CalculateResults.new(pod).call
      pod.save

      redirect_to pod, notice: 'Pod was successfully updated.'
    else
      render :edit, status: :unprocessable_entity, locals: { pod: }
    end
  end

  private

  def pod_params
    params.require(:pod).permit(:date, pod_results_attributes: %i[id user_id place])
  end
end
