require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }
  let(:guest_user) { create(:guest_user) }
  let(:game) { create(:game, person: guest_user, chosen_author: 'hi') }
  let(:correct_answers) { create_list(:game, 3, person: user, chosen_author: game.author) }
  let(:wrong_answers) { create_list(:game, 4, person: user, chosen_author: game.fake_authors[1]) }

  subject { user }
  it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }
  it { should have_many(:games) }

  describe 'validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :email }
  end

  it 'has merge game record method' do
    expect(user).to respond_to(:merge_game_record)
  end

  it 'merge guest_user to user' do
    game
    expect do
      subject.merge_game_record(guest_user.slug, user)
    end.to change { user.games.count }.by 1
  end

  it 'has correct_answers_count method from Person module' do
    correct_answers
    expect(subject.correct_answers_count).to eq(3)
  end

  it 'has wrong_answer_count method from Person module' do
    wrong_answers
    expect(subject.wrong_answer_count).to eq(4)
  end

  it 'has resolved_games method from Person module' do
    correct_answers
    wrong_answers
    expect(subject.resolved_games.count).to eq(7)
  end

  it 'has score_percent method from Person module' do
    score_percent = ((correct_answers.count / (correct_answers + wrong_answers).count.to_f) * 100).round(2)
    expect(subject.score_percent).to eq(score_percent)
  end
end
