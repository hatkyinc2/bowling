# frozen_string_literal: true

# BowlingGame class caluclates a game score out of indevidual roll inputs
class BowlingGame
  def initialize
    @attempts = []
    @frames = []
  end

  # no_of_pins is expected to be an integer between 0-10
  RANGE_ERR = 'no_of_pins out of expected range (0-10), was '
  def roll(no_of_pins)
    raise ArgumentError, RANGE_ERR + no_of_pins.to_s if no_of_pins.negative? || (no_of_pins > 10)

    @attempts.push(no_of_pins)

    @frames.push([])
    @frames[0].push(no_of_pins)
  end

  def score
    @frames[0].inject(0, :+)
  end
end
