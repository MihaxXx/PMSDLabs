class GameWritter: GameHandler {
    func _printBoard(game: Game) -> Void {
        print("----- Opponent's board -----\n");
        print("\t|A|B|C|D|E|F|G|H|I|J|");
        for i in 0...9 {
            print(i + 1, terminator: "\t|");
            for j in 0...9 {
                if (game.steps[i][j]) {
                    print(game.board[i][j] > 0 ? "X" : "-", terminator: "|");
                }
                else {
                    print(" ", terminator: "|");
                }
            }
            print("");
        }
    }
    
    func gameWasCreated(game: Game) {
        _printBoard(game: game);
    }
    
    func gameWaFinished(game: Game) {
        print("\nYOU WON!!!");
    }
    
    func afterStep(game: Game, stepResult: StepResult) {
        switch stepResult {
        case StepResult.Damage:
            print("You damaged the ship!\n");
        case StepResult.Kill:
            print("You destroyed the ship!\n");
        default:
            print("You missed!\n");
        }
        _printBoard(game: game);
    }
}
