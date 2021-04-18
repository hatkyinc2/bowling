# frozen_string_literal: true

# BowlingGame class caluclates a game score out of indevidual roll inputs
class BowlingGame
  def initialize
    @attempts = []
    @frames = [[]]

    @last_frame_split = false

    @prev_frame_strike_id = nil
    @last_frame_strike = false
  end

  # no_of_pins is expected to be an integer between 0-10
  RANGE_ERR = 'no_of_pins out of expected range (0-10), was '
  def roll(no_of_pins)
    validate_pin_input(no_of_pins)
    check_end_game # Not fully test covered yet

    # Record valid input
    @attempts.push(no_of_pins)

    current_frame_id = @frames.count - 1
    current_frame = @frames[current_frame_id]
    current_frame.push(no_of_pins)

    handle_split(current_frame_id, no_of_pins)
    handle_strike(current_frame_id, no_of_pins)

    identify_special_scores(current_frame)

    @frames.push([]) if frame_score(current_frame) == 10 || current_frame.count == 2 || current_frame_id > 10
  end

  def score
    total_score = 0
    0.upto([@frames.count - 1, 9].min) do |frame_id|
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

  def handle_strike(current_frame_id, no_of_pins)
    if @prev_frame_strike_id
      @frames[@prev_frame_strike_id].push(no_of_pins)
      @prev_frame_strike_id = nil
    end

    return unless @last_frame_strike

    frame_id = current_frame_id - 1
    @frames[frame_id].push(no_of_pins)
    @prev_frame_strike_id = frame_id
    @last_frame_strike = false
  end

  def identify_special_scores(current_frame)
    return unless frame_score(current_frame) == 10

    if current_frame.count == 2
      @last_frame_split = true
    else # current_frame.count == 1
      @last_frame_strike = true
    end
  end

  def check_end_game
    game_finished if @frames.count == 11 + extra_attempts
  end

  def extra_attempts
    return 2 if @prev_frame_strike_id
    return 1 if @prev_frame_strike_id || @last_frame_split || @last_frame_strike

    0
  end

  def game_finished
    raise ArgumentError, 'Game finished'
  end

  def validate_pin_input(no_of_pins)
    raise ArgumentError, RANGE_ERR + no_of_pins.to_s if no_of_pins.negative? || (no_of_pins > 10)
  end
end
