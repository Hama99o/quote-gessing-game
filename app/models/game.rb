class Game < ApplicationRecord
  before_save :set_default_val

  # validates_uniqueness_of :api_id
  def set_default_val
    self.score = author == chosen_author
  end
end
