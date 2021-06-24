require 'rails_helper'

RSpec.describe GuestUser, type: :model do
  let(:guest_user) { create(:guest_user) }
  let(:game) { create(:game, person: guest_user) }
  let(:correct_answers) { create_list(:game, 3, person: guest_user, chosen_author: game.author) }
  let(:wrong_answers) { create_list(:game, 4, person: guest_user, chosen_author: game.fake_authors[1]) }

  subject { guest_user }

  it { should have_many(:games) }

  it 'have name and email' do
    expect(subject).to respond_to(:name)
    expect(subject).to respond_to(:email)
  end

  it 'has random slug' do
    expect(subject.class.generate_guest_user).to eq(GuestUser.last)
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
