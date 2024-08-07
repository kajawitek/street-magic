# frozen_string_literal: true

RSpec.describe 'Pods', type: :system do
  current_date = Time.zone.today

  it 'add pod with results' do
    first_player = create(:user)
    second_player = create(:user)
    third_player = create(:user)
    login_as(first_player, scope: :user)

    visit root_path
    fill_in 'number_of_players', with: 3
    click_on 'Add New Pod'

    fill_in 'Date', with: current_date
    select first_player.full_name, from: 'pod_pod_results_attributes_0_user_id'
    select second_player.full_name, from: 'pod_pod_results_attributes_1_user_id'
    select third_player.full_name, from: 'pod_pod_results_attributes_2_user_id'

    fill_in 'pod_pod_results_attributes_0_place', with: 1
    fill_in 'pod_pod_results_attributes_1_place', with: 2
    fill_in 'pod_pod_results_attributes_2_place', with: 3

    expect do
      click_on 'Create Pod'
      expect(page).to have_content('Pod was successfully created')
    end.to change(Pod, :count).by(1)
                              .and change(PodResult, :count).by(3)
  end

  it 'edit pod with results' do
    pod = create(:pod)
    login_as(pod.users.first, scope: :user)

    visit root_path
    click_on 'Pods'
    click_on pod.date
    click_on 'Edit'

    fill_in 'Date', with: current_date - 1.day
    fill_in 'pod_pod_results_attributes_0_place', with: 1
    fill_in 'pod_pod_results_attributes_1_place', with: 2
    fill_in 'pod_pod_results_attributes_2_place', with: 3

    expect do
      click_on 'Update Pod'
    end.to(change { pod.pod_results.order(:place) })
  end

  it 'does not allow to create pod with date in the future' do
    user = create(:user)

    login_as(user, scope: :user)

    visit root_path
    fill_in 'number_of_players', with: 3
    click_on 'Add New Pod'

    fill_in 'Date', with: current_date + 1.day

    expect do
      click_on 'Create Pod'
      expect(page).to have_content("Date must be less than or equal to #{current_date.strftime('%Y-%m-%d')}")
    end.not_to change(Pod, :count)
  end
end
