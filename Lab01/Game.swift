class Game {
    var sheeps: [Sheep];
    var board: [[Int]];  // store positions of ships
    var steps: [[Bool]]; // store positions of steps
    var totalDamagedCells: Int = 0;
    var gameHandler: GameHandler?;
    
    init(sheeps: [Sheep], gameHandler: GameHandler?) {
        self.sheeps = sheeps;
        self.board = Array(repeating: Array(repeating: 0, count: 10), count: 10);
        self.steps = Array(repeating: Array(repeating: false, count: 10), count: 10);
        fillBoard();
        
        self.gameHandler = gameHandler;
        self.gameHandler?.gameWasCreated(game: self);
    }
    
    private func fillBoard() -> Void {
        sheeps.forEach {
            let dx = $0.shipDirection == ShipDirection.Right ? $0.size - 1 : 0;
            let dy = $0.shipDirection == ShipDirection.Down ? $0.size - 1 : 0;
            
            let (startX, startY) = $0.start;
            
            for j in (startX)...(startX + dx) {
                for i in (startY)...(startY + dy) {
                    board[i][j] = $0.size;
                }
            }
            
        }
    }
    
    private func _getSheepByPoint(x: Int, y: Int) -> Sheep? {
        for sheep in sheeps {
            if (
                sheep.shipDirection == ShipDirection.Down &&
                sheep.start.0 == x &&
                y >= sheep.start.1 && y <= sheep.start.1+sheep.size-1
            ) {
                return sheep;
            }
            if (
                sheep.shipDirection == ShipDirection.Right &&
                sheep.start.1 == y &&
                x >= sheep.start.0 && x <= sheep.start.0+sheep.size-1
            ) {
                return sheep;
            }
        }
        return nil;
    }
    
    func makeStep(row: Int, col: Int) -> Void {
        steps[row][col] = true;
        let sheep = _getSheepByPoint(x: col, y: row);
        var stepResult: StepResult = StepResult.None;
        
        if (sheep != nil) {
            sheep?.damagedCells += 1;
            self.totalDamagedCells += 1;
            stepResult = (sheep?.damagedCells == sheep?.size)
                ? StepResult.Kill
                : StepResult.Damage;
        }
        
        self.gameHandler?.afterStep(game: self, stepResult: stepResult);
        
        if (self.isWin()) {
            self.gameHandler?.gameWasCreated(game: self);
        }
    }
    
    func isWin() -> Bool {
        return self.totalDamagedCells == 30;
    }
}
