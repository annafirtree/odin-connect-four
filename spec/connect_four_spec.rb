# frozen_string_literal: true

require './lib/connect_four'

describe ConnectFour do
  subject do
    ConnectFour.new({ 1 => %w[O O O O O O],
                      2 => %w[O O O O O O],
                      3 => %w[W B B W O O],
                      4 => %w[B W W O O O],
                      5 => %w[B W W O O O],
                      6 => [bar, 'B', 'B', foo, 'O', 'O'],
                      7 => ['B', 'O', 'O', 'O', 'O', 'O'] })
  end
  let(:foo) { 'O' }
  let(:bar) { 'O' }

  describe '#valid_input?' do
    it 'accepts 1-7' do
      expect(subject.valid_input?(6)).to eql(true)
    end

    it 'refuses negatives' do
      expect(subject.valid_input?(-2)).to eql(false)
    end

    it 'refuses >7' do
      expect(subject.valid_input?(9)).to eql(false)
    end

    it 'refuses non-numbers' do
      expect(subject.valid_input?('a')).to eql(false)
    end
  end

  describe 'winner' do
    context 'white wins, diagonal right' do
      let(:foo) { 'W' }
      # let(:bar) { 'O' }
      it { expect(subject.winner).to eql('White') }
    end

    context 'white wins, diagonal left' do
      let(:bar) { 'W' }
      # let(:bar) { 'O' }
      it { expect(subject.winner).to eql('White') }
    end

    context 'black wins, vertically' do
      let(:foo) { 'B' }
      let(:bar) { 'B' }
      it { expect(subject.winner).to eql('Black') }
    end

    context 'black wins, horizontally' do
      # let(:foo) { 'O' }
      let(:bar) { 'B' }
      it { expect(subject.winner).to eql('Black') }
    end

    context 'no winner yet' do
      # let(:foo) { 'O' }
      # let(:bar) { 'O' }
      it { expect(subject.winner).to eql('None') }
    end

    context 'tie' do
      it do
        hash = { 1 => %w[B W B W W B],
                 2 => %w[W B W B W W],
                 3 => %w[W B W B B W],
                 4 => %w[B W B W B W],
                 5 => %w[B B W B W B],
                 6 => %w[W B W B W B],
                 7 => %w[W W B W B W] }
        subject.instance_variable_set(:@board, hash)
        expect(subject.winner).to eql('Tie')
      end
    end
  end

  describe 'play a turn' do
    context 'white plays' do
      # let(:foo) { 'O' }
      # let(:bar) { 'W' }
      it do
        subject.play_a_turn('White', 1)
        new_hash = { 1 => %w[W O O O O O],
                     2 => %w[O O O O O O],
                     3 => %w[W B B W O O],
                     4 => %w[B W W O O O],
                     5 => %w[B W W O O O],
                     6 => %w[O B B O O O],
                     7 => %w[B O O O O O] }
        expect(subject.instance_variable_get(:@board)).to eql(new_hash)
      end
    end
  end

  describe 'done?' do
    context 'done' do
      let(:foo) { 'B' }
      let(:bar) { 'W' }
      it { expect(subject.done?).to eql(true) }
    end

    context 'not done' do
      # let(:foo) { 'O' }
      # let(:bar) { 'O' }
      it { expect(subject.done?).to eql(false) }
    end
  end
end
