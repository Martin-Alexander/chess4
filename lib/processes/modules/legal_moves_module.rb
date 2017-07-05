module LegalMovesModule
  include Helpers

  def run

    all_legal_moves = []

    setup

    turnplayer_squares.each do |square|
      moves_of(square).each do |move|
        all_legal_moves << move
      end
    end

    all_legal_moves.flatten
  end

  def setup
    @turnplayer_color = @game_state.white_to_move ? :white : :black 
    @board = @game_state.board
  end

  def turnplayer_squares
    start_time = Time.now

    output = []
    each_square do |square|
      if @board[square].color == @turnplayer_color
        output << Square.new(square)
      end
    end

    output
  end

  def moves_of(square)
    send(@board[square.symbol].piece, square)
  end

  def king_safe?
  end

  def pawn(square)
    output = []
    rank, file = square.rank, square.file

    # Direction indepenedent rank advance 
    move_one = @game_state.white_to_move ? 1 : -1
    move_two = @game_state.white_to_move ? 2 : -2

    # Double and single rank advance
    if (@board[rank + move_one, file] rescue false) && @board[rank + move_one, file].empty?
      output << Move.new_pawn_move(square, square.translate( rank: move_one, file: 0 ))
      if (@board[rank + move_two, file] rescue false) && ((square.rank == 2 && @turnplayer_color == :white) || (square.rank == 7 && @turnplayer_color == :black)) && 
        @board[rank + move_two, file].empty?
        output << Move.new_pawn_move(square, square.translate(rank: move_two, file: 0 ), double_advance: true)
      end
    end

    # Regular capture
    left_capture = @board[rank + move_one, file - 1] rescue false
    if left_capture && !left_capture.empty? && left_capture.color != @turnplayer_color
      output << Move.new_pawn_move(square, square.translate(rank: move_one, file: -1), capture: true)
    end
    right_capture = @board[rank + move_one, file + 1] rescue false
    if right_capture && !right_capture.empty? && right_capture.color != @turnplayer_color
      output << Move.new_pawn_move(square, square.translate(rank: move_one, file: 1), capture: true)
    end
    
    # En passant capture
    if left_capture && square.translate(rank: move_one, file: -1).symbol == @game_state.en_passant
      output << Move.new_pawn_move(square, square.translate(rank: move_one, file: -1), capture: true, en_passant_capture: true)
    end
    if right_capture && square.translate(rank: move_one, file: 1).symbol == @game_state.en_passant
      output << Move.new_pawn_move(square, square.translate(rank: move_one, file: 1), capture: true, en_passant_capture: true)
    end      

    output.flatten
  end

  def knight(square)
    knight_move_translations = [
      {rank: 2, file: 1},
      {rank: 2, file: -1},
      {rank: 1, file: 2},
      {rank: 1, file: -2},
      {rank: -2, file: 1},
      {rank: -2, file: -1},
      {rank: -1, file: 2},
      {rank: -1, file: -2}
    ]

    knight_move_translations.each_with_object([]) do |move_translation, output|
      if square.translate(move_translation) rescue false 
        if @board[square.translate(move_translation).symbol].empty?
          output << Move.new(square, square.translate(move_translation))
        elsif @board[square.translate(move_translation).symbol].color != @turnplayer_color
          output << Move.new(square, square.translate(move_translation), capture: true)
        end
      end
    end
  end

  def bishop(square)
    []
  end

  def rook(square)
    []
  end

  def queen(square)
    []
  end

  def king(square)
    []
  end
end