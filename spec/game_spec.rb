require_relative 'spec_helper'
require_relative '../lib/multi_tic_tac_toe'

shared_context "moves ends in winner" do
  before {
    moves.each { |e| subject.move(*e) }
  }
  it "game_over?" do
    expect(subject.game_over?).to eq true
  end

  it "winner is" do
    expect(subject.winner).to eq winner
  end
end

describe MultiTicTacToe::Game do

  describe "winning" do
    let(:dimensions) {2}
    let(:grid) {3}
    let(:winner) { subject.players.first }
    subject { MultiTicTacToe::Game.new(dimensions, grid, message: false) }

    describe "basic game" do
      let(:moves) {
        [
          [ 0, 0 ], [ 2, 0 ],
          [ 1, 1 ], [ 1, 0 ],
          [ 2, 2 ]
        ]
      }
      include_context "moves ends in winner"
    end

    describe "basic game when winning move is not on an edge" do
      let(:moves) {
        [
          [ 0, 0 ], [ 2, 0 ],
          [ 2, 2 ], [ 1, 0 ],
          [ 1, 1 ]
        ]
      }
      include_context "moves ends in winner"
    end

    describe "3 dimensions, 4 grid" do
      let(:dimensions) {3}
      let(:grid) {4}
      let(:moves) {
        [
          [ 0, 0, 0 ], [ 2, 0, 1 ],
          [ 3, 3, 3 ], [ 0, 0, 1 ],
          [ 1, 1, 1 ], [ 1, 0, 1 ],
          [ 2, 2, 2 ]
        ]
      }
      include_context "moves ends in winner"
    end
  end
end
