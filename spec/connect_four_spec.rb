require 'rspec'
require './connect_four'

# board should allow player to make moves
# board should update
# board should check win condition after each move


describe Board do

  describe "attributes" do

    subject do
      Board.new(:grid => [Square.new([5,5])])
    end

    it { is_expected.to respond_to(:grid) }
  end

  describe '#display' do

    let(:board2) do
      board2 = Board.new(Grid.new(5, 6))
      board2
    end

    context "when Board.grid has a 5-by-6 grid" do
      it "displays a 5-by-6 grid" do
        expect { board2.display }.to output(
"""|_ _||_ _||_ _||_ _||_ _||_ _|\n|_ _||_ _||_ _||_ _||_ _||_ _|
|_ _||_ _||_ _||_ _||_ _||_ _|\n|_ _||_ _||_ _||_ _||_ _||_ _|
|_ _||_ _||_ _||_ _||_ _||_ _|\n--0----1----2----3----4--"""
        ).to_stdout
      end
    end
  end

  describe '#choose_move column' do

    let(:board3) do
      board3 = Board.new(Grid.new(2,2))
      board3
    end

    context "when column 0 is chosen and available" do
      it "updates the first square in column 0 with player's symbol" do
        expect(board3.choose_move(0).symbol).to eql('X')
      end
    end

    context "when a column is chosen that is full" do
      it "it returns 'Choose again.'" do
        board3.choose_move(0)
        board3.choose_move(0)
        expect(board3.choose_move(0)).to eql('Choose again.')
        #expect { board3.choose_move(0) }.to output('Choose again.').to_stdout
      end
    end


  end

  describe '#update_grid' do
  end

  describe '#frontslash_win?' do

    let(:board4) do
      board4 = Board.new(Grid.new(6, 7))
      board4.choose_move(1)
      board4.choose_move(2)
      board4.choose_move(2)
      board4.choose_move(3)
      board4.choose_move(3)
      board4.choose_move(3)
      board4.grid.find_by_loc([0,5]).symbol = 'O'
      board4.grid.find_by_loc([1,4]).symbol = 'O'
      board4.grid.find_by_loc([2,3]).symbol = 'O'
      board4.grid.find_by_loc([3,2]).symbol = 'O'
    end

    context "when the board has a frontslash of four squares" do
      it "returns 'You win!'" do
        expect(board4.frontslash_win?).to eql("You win!")
      end
    end
  end


end




describe Square do
  describe "attributes" do

    subject do
      Square.new(:player => nil,
                 :symbol => 'O', 
                 :position => [0, 1])
    end

    it { is_expected.to respond_to(:player) }
    it { is_expected.to respond_to(:symbol) }
    it { is_expected.to respond_to(:position) }
  end
end

describe Grid do
  describe "attributes" do

    subject do
      Grid.new(1, 2)
    end

    it { is_expected.to respond_to(:rows) }
    it { is_expected.to respond_to(:columns) }
  end


  describe '#create_grid columns, rows' do

    let(:grid1) do
      Grid.new(5, 6)
    end

    context "when given 5 rows and 6 columns" do
      it "creates an array of 30 Square members" do
        expect(grid1.members.length).to eql(30)
        expect(grid1.members.sample.is_a? Square).to be true
      end
    end

  end


  describe '#collect_members_by_row' do
    let(:grid2) do
      Grid.new(2,4)
    end

    context "when given a grid with 2 rows" do
      it "returns a hash with 2 keys" do
        expect(grid2.collect_members_by_row.length).to eql(2)
      end
    end
  end

  describe '#collect_members_by_column' do
    let(:grid3) do
      Grid.new(2,4)
    end

    context "when given a grid with 4 rows" do
      it "returns a hash with 4 keys" do
        expect(grid3.collect_members_by_column.length).to eql(4)
      end
    end
  end

  describe '#find_by_loc' do
    let(:grid4) do
      Grid.new(6,7)
    end

    context "when given the array [2,3]" do
      it "returns the Square at position [2,3]" do
        expect(grid4.find_by_loc([2,3]).position).to eql([2,3])
      end
    end
  end

end

