# frozen_string_literal: true

RSpec.describe 'Pods::CalculateResults' do
  it 'calculates the scores for the basic 3-players pod results' do
    pod = build(:pod)

    first_place = build(:pod_result, place: 1)
    second_place = build(:pod_result, place: 2)
    third_place = build(:pod_result, place: 3)
    pod.pod_results = [second_place, first_place, third_place]

    expect(Pods::CalculateResults.new(pod).call).to be true

    expect(third_place.score).to eq(1)
    expect(second_place.score).to eq(2)
    expect(first_place.score).to eq(3)
  end

  it 'calculates the scores for the basic 5-players pod results' do
    pod = build(:pod)

    first_place = build(:pod_result, place: 1)
    second_place = build(:pod_result, place: 2)
    third_place = build(:pod_result, place: 3)
    fourth_place = build(:pod_result, place: 4)
    fifth_place = build(:pod_result, place: 5)
    pod.pod_results = [fifth_place, second_place, first_place, third_place, fourth_place]

    expect(Pods::CalculateResults.new(pod).call).to be true

    expect(fifth_place.score).to eq(1)
    expect(fourth_place.score).to eq(2)
    expect(third_place.score).to eq(3)
    expect(second_place.score).to eq(4)
    expect(first_place.score).to eq(5)
  end

  it 'calculates the scores for the 4-players pod results with a tie' do
    pod = build(:pod)

    first_place = build(:pod_result, place: 1)
    second_place = build(:pod_result, place: 2)
    fourth_place1 = build(:pod_result, place: 4)
    fourth_place2 = build(:pod_result, place: 4)
    pod.pod_results = [second_place, first_place, fourth_place1, fourth_place2]

    expect(Pods::CalculateResults.new(pod).call).to be true

    expect(first_place.score).to eq(4)
    expect(second_place.score).to eq(3)
    expect(fourth_place1.score).to eq(1)
    expect(fourth_place2.score).to eq(1)
  end

  it 'calculates the scores for the 4-players pod results with a tie and wrong places' do
    pod = build(:pod)

    first_place = build(:pod_result, place: 1)
    third_place1 = build(:pod_result, place: 2)
    third_place2 = build(:pod_result, place: 2)
    fourth_place = build(:pod_result, place: 4)
    pod.pod_results = [third_place1, first_place, third_place2, fourth_place]

    expect(Pods::CalculateResults.new(pod).call).to be true

    expect(fourth_place.score).to eq(1)
    expect(third_place1.score).to eq(2)
    expect(third_place2.score).to eq(2)
    expect(first_place.score).to eq(4)
  end

  it 'calculates the scores for the 4-players pod results with a tie for all players' do
    pod = build(:pod)

    third_place1 = build(:pod_result, place: 3)
    third_place2 = build(:pod_result, place: 3)
    third_place3 = build(:pod_result, place: 3)
    pod.pod_results = [third_place1, third_place2, third_place3]

    expect(Pods::CalculateResults.new(pod).call).to be true

    expect(third_place1.score).to eq(1)
    expect(third_place2.score).to eq(1)
    expect(third_place3.score).to eq(1)
  end
end
