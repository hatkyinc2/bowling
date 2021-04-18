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
  end
end
