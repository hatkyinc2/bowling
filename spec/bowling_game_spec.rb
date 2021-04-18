# frozen_string_literal: true

require_relative '../bowling/bowling_game'

describe BowlingGame do
  describe 'roll' do
    bg = BowlingGame.new
    context 'Given a negative number of rolls' do
      it 'returns an exception' do
        expect do
          bg.roll(-1)
        end.to raise_error(ArgumentError)
      end
    end
    context 'Given number of rolls 11' do
      it 'returns an exception' do
        expect do
          bg.roll(11)
        end.to raise_error(ArgumentError)
      end
    end
    context 'Given number of rolls 0-10' do
      it "doesn't return an exception" do
        expect do
          0.upto(10) do |i|
            bg.roll(i)
          end
        end.not_to raise_error
      end
    end
  end

  describe 'score' do
    context 'Given two rolls' do
      it 'Return a score joining them' do
        bg = BowlingGame.new
        bg.roll(4)
        bg.roll(4)
        expect(bg.score).to eq(8)

        bg = BowlingGame.new
        bg.roll(2)
        bg.roll(5)
        expect(bg.score).to eq(7)
      end
    end

    context 'Given three rolls' do
      it 'Return a score joining them' do
        bg = BowlingGame.new
        bg.roll(4)
        bg.roll(4)
        bg.roll(1)
        expect(bg.score).to eq(9)

        bg = BowlingGame.new
        bg.roll(2)
        bg.roll(5)
        bg.roll(3)
        expect(bg.score).to eq(10)
      end

      it 'Calculates the spare rule' do
        bg = BowlingGame.new
        bg.roll(2)
        bg.roll(8)

        bg.roll(3)
        expect(bg.score).to eq(16)

        bg = BowlingGame.new
        bg.roll(6)
        bg.roll(4)

        bg.roll(5)
        expect(bg.score).to eq(20)
      end
      it 'Calculates the stike rule' do
        bg = BowlingGame.new
        bg.roll(10)
        bg.roll(2)
        bg.roll(2)
        expect(bg.score).to eq(18)

        bg = BowlingGame.new
        bg.roll(10)
        bg.roll(5)
        bg.roll(5)
        expect(bg.score).to eq(30)

        bg = BowlingGame.new
        bg.roll(10)
        bg.roll(9)
        bg.roll(9)
        expect(bg.score).to eq(46)
      end
    end
    context 'Full game samples' do
      it 'Returns the right score' do
        attempts = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        bg = BowlingGame.new
        attempts.each do |no_of_pins|
          bg.roll(no_of_pins)
        end
        expect(bg.score).to eq(0)

        attempts = [0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        bg = BowlingGame.new
        attempts.each do |no_of_pins|
          bg.roll(no_of_pins)
        end
        expect(bg.score).to eq(1)

        # Split mid game
        attempts = [0, 0, 0, 0, 2, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        bg = BowlingGame.new
        attempts.each do |no_of_pins|
          bg.roll(no_of_pins)
        end
        expect(bg.score).to eq(10)

        # Split mid game
        attempts = [0, 0, 0, 0, 2, 8, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        bg = BowlingGame.new
        attempts.each do |no_of_pins|
          bg.roll(no_of_pins)
        end
        expect(bg.score).to eq(12)

        # Strick mid game
        attempts = [0, 0, 0, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        bg = BowlingGame.new
        attempts.each do |no_of_pins|
          bg.roll(no_of_pins)
        end
        expect(bg.score).to eq(12)

        # Strick mid game
        attempts = [0, 0, 0, 0, 10, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        bg = BowlingGame.new
        attempts.each do |no_of_pins|
          bg.roll(no_of_pins)
        end
        expect(bg.score).to eq(12)

        # Strick mid game
        attempts = [0, 0, 0, 0, 10, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        bg = BowlingGame.new
        attempts.each do |no_of_pins|
          bg.roll(no_of_pins)
        end
        expect(bg.score).to eq(14)
      end
    end

    context 'Special end game samples' do
      it 'Limits to 10 frames' do
        attempts = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        bg = BowlingGame.new
        attempts.each do |no_of_pins|
          bg.roll(no_of_pins)
        end
        expect do
          bg.roll(0)
        end.to raise_error(ArgumentError)
      end

      it '10 frames with split' do
        attempts = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 9, 0]
        bg = BowlingGame.new
        attempts.each do |no_of_pins|
          bg.roll(no_of_pins)
        end
        expect(bg.score).to eq(10)

        attempts = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 9, 1]
        bg = BowlingGame.new
        attempts.each do |no_of_pins|
          bg.roll(no_of_pins)
        end
        expect(bg.score).to eq(11)
      end

      it '10 frames with strike' do
        attempts = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0]
        bg = BowlingGame.new
        attempts.each do |no_of_pins|
          bg.roll(no_of_pins)
        end
        expect(bg.score).to eq(10)

        attempts = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 0, 1]
        bg = BowlingGame.new
        attempts.each do |no_of_pins|
          bg.roll(no_of_pins)
        end
        expect(bg.score).to eq(11)

        attempts = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10, 0]
        bg = BowlingGame.new
        attempts.each do |no_of_pins|
          bg.roll(no_of_pins)
        end
        expect(bg.score).to eq(20)

        attempts = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 0, 10]
        bg = BowlingGame.new
        attempts.each do |no_of_pins|
          bg.roll(no_of_pins)
        end
        expect(bg.score).to eq(20)

        attempts = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10, 10]
        bg = BowlingGame.new
        attempts.each do |no_of_pins|
          bg.roll(no_of_pins)
        end
        expect(bg.score).to eq(30)

        attempts = [10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10]
        bg = BowlingGame.new
        attempts.each do |no_of_pins|
          bg.roll(no_of_pins)
        end
        expect(bg.score).to eq(300)
      end

      # TODO: Capture all end of game conditions - out of current scope
    end
  end
end
