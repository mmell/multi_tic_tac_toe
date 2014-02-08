require_relative 'spec_helper'
require_relative '../lib/multi_tic_tac_toe/position'

shared_context "lines_through" do
  it "has the expected set" do
    expect(subject.lines.sort).to eq expected.sort
  end
end

shared_context "dimension_matrix" do
  it "works" do
    expect(
      subject.dimension_matrix.sort
    ).to eq expected.sort
  end
end

describe MultiTicTacToe::Position do

  let(:dimensions) {2}
  let(:grid) {3}

  describe "dimension_matrix" do
    subject { MultiTicTacToe::Position.new(dimensions, grid) }

    describe "2d" do
      let(:expected) { [[0], [1], [0,1]] }
      include_context "dimension_matrix"
    end

    describe "3d" do
      let(:dimensions) {3}
      let(:expected) { [
        [0], [0, 1], [0, 1, 2], [0, 2], [1], [1, 2], [2], [2, 1]
      ]
      }
      include_context "dimension_matrix"
    end
  end

  describe "default" do
    subject { MultiTicTacToe::Position.new(dimensions, grid) }

    it "is an array" do
      expect(subject.is_a?(Array)).to be
    end

    it "sized to dimensions" do
      expect(subject.size).to eq(dimensions)
    end

    it "defaulting to 0" do
      expect(subject.select { |e| e != 0 }).to eq([])
    end

  end

  describe "populated" do
    let(:value) { 1 }
    subject { MultiTicTacToe::Position.new(dimensions, grid, value, value) }

    it "with 1s" do
      expect(subject.select { |e| e != value }).to eq([])
    end

  end

  describe "#lines_through" do
    subject { MultiTicTacToe::Position.new(dimensions, grid, *position) }

    describe "2 dimensions" do
      describe "3 grid" do
        describe "0, 0" do
          let(:expected) {
            [
              [position, [1, 0], [2, 0]],
              [position, [0, 1], [0, 2]],
              [position, [1, 1], [2, 2]],
            ]
          }
          let(:position) { [0, 0] }
          include_context "lines_through"
        end

        describe "1, 0" do
          let(:expected) {
            [
              [position, [1, 1], [1, 2]],
            ]
          }
          let(:position) { [1, 0] }
          include_context "lines_through"
        end

        describe "0, 2" do
          let(:expected) {
            [
              [[0, 2], [0, 1], [0, 0]],
              [[0, 2], [1, 2], [2, 2]],
              [[0, 2], [1, 1], [2, 0]],
            ]
          }
          let(:position) { [0, 2] }
          include_context "lines_through"
        end
      end
    end

    describe "3 dimensions" do
      describe "3 grid" do
        describe "0, 0, 0" do
          let(:expected) {
            [
              [position, [1, 0, 0], [2, 0, 0]],
              [position, [0, 1, 0], [0, 2, 0]],
              [position, [0, 0, 1], [0, 0, 2]],

              [position, [1, 1, 0], [2, 2, 0]],
              [position, [0, 1, 1], [0, 2, 2]],
              [position, [1, 0, 1], [2, 0, 2]],

              [position, [1, 1, 1], [2, 2, 2]],
            ]
          }
          let(:position) { [0, 0, 0] }
          include_context "lines_through"
        end

        describe "1, 0, 0" do
          let(:expected) {
            [
              [position, [1, 1, 0], [1, 2, 0]],
              [position, [1, 0, 1], [1, 0, 2]],

              [position, [1, 1, 1], [1, 2, 2]],
            ]
          }
          let(:position) { [1, 0, 0] }
          include_context "lines_through"
        end

        describe "0, 2, 0" do
          let(:expected) {
            [
              [[0, 2, 0], [0, 1, 0], [0, 0, 0]],
              [[0, 2, 0], [0, 1, 1], [0, 0, 2]],
              [[0, 2, 0], [0, 2, 1], [0, 2, 2]],
              [[0, 2, 0], [1, 1, 0], [2, 0, 0]],
              [[0, 2, 0], [1, 1, 1], [2, 0, 2]],
              [[0, 2, 0], [1, 2, 0], [2, 2, 0]],
              [[0, 2, 0], [1, 2, 1], [2, 2, 2]]
            ]
          }
          let(:position) { [0, 2, 0] }
          include_context "lines_through"
        end
      end

    end

    describe "4 dimensions" do
      describe "3 grid" do

        describe "0, 0, 0, 0" do
          let(:expected) {
            [
              [[0, 0, 0, 0], [0, 0, 0, 1], [0, 0, 0, 2]],
              [[0, 0, 0, 0], [0, 0, 1, 0], [0, 0, 2, 0]],
              [[0, 0, 0, 0], [0, 0, 1, 1], [0, 0, 2, 2]],
              [[0, 0, 0, 0], [0, 1, 0, 0], [0, 2, 0, 0]],
              [[0, 0, 0, 0], [0, 1, 0, 1], [0, 2, 0, 2]],
              [[0, 0, 0, 0], [0, 1, 1, 0], [0, 2, 2, 0]],
              [[0, 0, 0, 0], [0, 1, 1, 1], [0, 2, 2, 2]],
              [[0, 0, 0, 0], [1, 0, 0, 0], [2, 0, 0, 0]],
              [[0, 0, 0, 0], [1, 0, 0, 1], [2, 0, 0, 2]],
              [[0, 0, 0, 0], [1, 0, 1, 0], [2, 0, 2, 0]],
              [[0, 0, 0, 0], [1, 0, 1, 1], [2, 0, 2, 2]],
              [[0, 0, 0, 0], [1, 1, 0, 0], [2, 2, 0, 0]],
              [[0, 0, 0, 0], [1, 1, 0, 1], [2, 2, 0, 2]],
              [[0, 0, 0, 0], [1, 1, 1, 0], [2, 2, 2, 0]],
              [[0, 0, 0, 0], [1, 1, 1, 1], [2, 2, 2, 2]]
            ]
          }
          let(:position) { [0, 0, 0, 0] }
          include_context "lines_through"
        end

        describe "0, 1, 0, 0" do
          let(:expected) {
            [
              [[0, 1, 0, 0], [0, 1, 0, 1], [0, 1, 0, 2]],
              [[0, 1, 0, 0], [0, 1, 1, 0], [0, 1, 2, 0]],
              [[0, 1, 0, 0], [0, 1, 1, 1], [0, 1, 2, 2]],
              [[0, 1, 0, 0], [1, 1, 0, 0], [2, 1, 0, 0]],
              [[0, 1, 0, 0], [1, 1, 0, 1], [2, 1, 0, 2]],
              [[0, 1, 0, 0], [1, 1, 1, 0], [2, 1, 2, 0]],
              [[0, 1, 0, 0], [1, 1, 1, 1], [2, 1, 2, 2]]
            ]
          }
          let(:position) { [0, 1, 0, 0] }
          include_context "lines_through"
        end

        describe "0, 0, 2, 0" do
          let(:expected) {
            [
              [[0, 0, 2, 0], [0, 0, 1, 0], [0, 0, 0, 0]],
              [[0, 0, 2, 0], [0, 0, 1, 1], [0, 0, 0, 2]],
              [[0, 0, 2, 0], [0, 0, 2, 1], [0, 0, 2, 2]],
              [[0, 0, 2, 0], [0, 1, 1, 0], [0, 2, 0, 0]],
              [[0, 0, 2, 0], [0, 1, 1, 1], [0, 2, 0, 2]],
              [[0, 0, 2, 0], [0, 1, 2, 0], [0, 2, 2, 0]],
              [[0, 0, 2, 0], [0, 1, 2, 1], [0, 2, 2, 2]],
              [[0, 0, 2, 0], [1, 0, 1, 0], [2, 0, 0, 0]],
              [[0, 0, 2, 0], [1, 0, 1, 1], [2, 0, 0, 2]],
              [[0, 0, 2, 0], [1, 0, 2, 0], [2, 0, 2, 0]],
              [[0, 0, 2, 0], [1, 0, 2, 1], [2, 0, 2, 2]],
              [[0, 0, 2, 0], [1, 1, 1, 0], [2, 2, 0, 0]],
              [[0, 0, 2, 0], [1, 1, 1, 1], [2, 2, 0, 2]],
              [[0, 0, 2, 0], [1, 1, 2, 0], [2, 2, 2, 0]],
              [[0, 0, 2, 0], [1, 1, 2, 1], [2, 2, 2, 2]]
            ]
          }
          let(:position) { [0, 0, 2, 0] }
          include_context "lines_through"
        end
      end
    end

    describe "4 dimensions" do
      describe "4 grid" do
        let(:grid) {4}

        describe "0, 0, 0, 0" do
          let(:expected) {
            [
              [[0, 0, 0, 0], [0, 0, 0, 1], [0, 0, 0, 2], [0, 0, 0, 3]],
              [[0, 0, 0, 0], [0, 0, 1, 0], [0, 0, 2, 0], [0, 0, 3, 0]],
              [[0, 0, 0, 0], [0, 0, 1, 1], [0, 0, 2, 2], [0, 0, 3, 3]],
              [[0, 0, 0, 0], [0, 1, 0, 0], [0, 2, 0, 0], [0, 3, 0, 0]],
              [[0, 0, 0, 0], [0, 1, 0, 1], [0, 2, 0, 2], [0, 3, 0, 3]],
              [[0, 0, 0, 0], [0, 1, 1, 0], [0, 2, 2, 0], [0, 3, 3, 0]],
              [[0, 0, 0, 0], [0, 1, 1, 1], [0, 2, 2, 2], [0, 3, 3, 3]],
              [[0, 0, 0, 0], [1, 0, 0, 0], [2, 0, 0, 0], [3, 0, 0, 0]],
              [[0, 0, 0, 0], [1, 0, 0, 1], [2, 0, 0, 2], [3, 0, 0, 3]],
              [[0, 0, 0, 0], [1, 0, 1, 0], [2, 0, 2, 0], [3, 0, 3, 0]],
              [[0, 0, 0, 0], [1, 0, 1, 1], [2, 0, 2, 2], [3, 0, 3, 3]],
              [[0, 0, 0, 0], [1, 1, 0, 0], [2, 2, 0, 0], [3, 3, 0, 0]],
              [[0, 0, 0, 0], [1, 1, 0, 1], [2, 2, 0, 2], [3, 3, 0, 3]],
              [[0, 0, 0, 0], [1, 1, 1, 0], [2, 2, 2, 0], [3, 3, 3, 0]],
              [[0, 0, 0, 0], [1, 1, 1, 1], [2, 2, 2, 2], [3, 3, 3, 3]]
            ]
          }
          let(:position) { [0, 0, 0, 0] }
          include_context "lines_through"
        end

        describe "0, 1, 0, 0" do
          let(:expected) {
            [
              [[0, 1, 0, 0], [0, 1, 0, 1], [0, 1, 0, 2], [0, 1, 0, 3]],
              [[0, 1, 0, 0], [0, 1, 1, 0], [0, 1, 2, 0], [0, 1, 3, 0]],
              [[0, 1, 0, 0], [0, 1, 1, 1], [0, 1, 2, 2], [0, 1, 3, 3]],
              [[0, 1, 0, 0], [1, 1, 0, 0], [2, 1, 0, 0], [3, 1, 0, 0]],
              [[0, 1, 0, 0], [1, 1, 0, 1], [2, 1, 0, 2], [3, 1, 0, 3]],
              [[0, 1, 0, 0], [1, 1, 1, 0], [2, 1, 2, 0], [3, 1, 3, 0]],
              [[0, 1, 0, 0], [1, 1, 1, 1], [2, 1, 2, 2], [3, 1, 3, 3]]
            ]
          }
          let(:position) { [0, 1, 0, 0] }
          include_context "lines_through"
        end

        describe "0, 0, 2, 0" do
          let(:expected) {
            [
              [[0, 0, 2, 0], [0, 0, 2, 1], [0, 0, 2, 2], [0, 0, 2, 3]],
              [[0, 0, 2, 0], [0, 1, 2, 0], [0, 2, 2, 0], [0, 3, 2, 0]],
              [[0, 0, 2, 0], [0, 1, 2, 1], [0, 2, 2, 2], [0, 3, 2, 3]],
              [[0, 0, 2, 0], [1, 0, 2, 0], [2, 0, 2, 0], [3, 0, 2, 0]],
              [[0, 0, 2, 0], [1, 0, 2, 1], [2, 0, 2, 2], [3, 0, 2, 3]],
              [[0, 0, 2, 0], [1, 1, 2, 0], [2, 2, 2, 0], [3, 3, 2, 0]],
              [[0, 0, 2, 0], [1, 1, 2, 1], [2, 2, 2, 2], [3, 3, 2, 3]]
            ]
          }
          let(:position) { [0, 0, 2, 0] }
          include_context "lines_through"
        end
      end
    end
  end

end
