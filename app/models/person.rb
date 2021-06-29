module Person
  def resolved_games
    games.where.not(chosen_author: nil).order(created_at: :desc)
  end

  def correct_answers_count
    games.where(has_guessed: true).count
  end

  def wrong_answer_count
    games.where(has_guessed: false).count
  end

  def score_percent
    (correct_answers_count / resolved_games.count.to_f) * 100
  end
end
