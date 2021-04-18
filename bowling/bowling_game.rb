# frozen_string_literal: true

# BowlingGame class caluclates a game score out of indevidual roll inputs
class BowlingGame
  def initialize
    @attempts = []
    @frames = [[]]

    @last_frame_split = false
  end

  # no_of_pins is expected to be an integer between 0-10
  RANGE_ERR = 'no_of_pins out of expected range (0-10), was '
  def roll(no_of_pins)
    raise ArgumentError, RANGE_ERR + no_of_pins.to_s if no_of_pins.negative? || (no_of_pins > 10)

    # Record valid input
    @attempts.push(no_of_pins)

    current_frame_id = @frames.count - 1
    current_frame = @frames[current_frame_id]
    current_frame.push(no_of_pins)

    handle_split(current_frame_id, no_of_pins)

    # Process frame
    @last_frame_split = true if frame_score(current_frame) == 10
    @frames.push([]) if frame_score(current_frame) == 10 || current_frame.count == 2
  end

  def score
    total_score = 0
    0.upto(@frames.count - 1) do |frame_id|
      frame = @frames[frame_id]
      total_score += frame_score(frame)
    end
    total_score
  end

  private

  def frame_score(current_frame)
    current_frame.inject(0, :+)
  end

  def handle_split(current_frame_id, no_of_pins)
    return unless @last_frame_split

    split_frame_id = current_frame_id - 1
    @frames[split_frame_id].push(no_of_pins)
    @last_frame_split = false
  end
end
