# frozen_string_literal: true

module Pods
  class CalculateResults
    def initialize(pod)
      @pod = pod
    end

    def call
      calculate(@pod.pod_results.to_a)
      true
    end

    private

    def calculate(pod_results)
      pod_results.sort_by!(&:place)
      current_index = 0

      while current_index < pod_results.size
        tie_count = count_ties(pod_results, current_index)
        tie_score = calculate_tie_score(pod_results.size, current_index, tie_count)
        assign_scores(pod_results, current_index, tie_count, tie_score)
        current_index += tie_count
      end

      pod_results
    end

    def count_ties(pod_results, current_index)
      current_place = pod_results[current_index].place
      tie_count = 1

      while current_index + tie_count < pod_results.size &&
            pod_results[current_index + tie_count].place == current_place
        tie_count += 1
      end

      tie_count
    end

    def calculate_tie_score(total_results, current_index, tie_count)
      total_results - (current_index + tie_count) + 1
    end

    def assign_scores(pod_results, current_index, tie_count, tie_score)
      (0...tie_count).each do |i|
        pod_results[current_index + i].score = tie_score
      end
    end
  end
end
