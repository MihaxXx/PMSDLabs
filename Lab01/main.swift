enum ShipDirection { case Right, Down };

enum StepResult { case None, Damage, Kill };

class Sheep {
    var shipDirection: ShipDirection;
    var start: (Int, Int);
    var size: Int;
    var damagedCells: Int = 0;
    
    init(shipDirection: ShipDirection, start: (Int, Int), size: Int) {
        self.shipDirection = shipDirection;
        self.start = start;
        self.size = size;
    }
}

protocol GameHandler {
    func gameWasCreated(game: Game) -> Void;
    func gameWaFinished(game: Game) -> Void;
    func afterStep(game: Game, stepResult: StepResult) -> Void;
}

var sheeps = [
    Sheep(shipDirection: ShipDirection.Right, start: (0, 0), size: 2),
    Sheep(shipDirection: ShipDirection.Right, start: (6, 0), size: 4),
    Sheep(shipDirection: ShipDirection.Down, start: (3, 0), size: 3),
    Sheep(shipDirection: ShipDirection.Down, start: (0, 2), size: 4),
    Sheep(shipDirection: ShipDirection.Right, start: (5, 2), size: 3),
    Sheep(shipDirection: ShipDirection.Down, start: (9, 2), size: 2),
    Sheep(shipDirection: ShipDirection.Down, start: (5, 5), size: 2),
    Sheep(shipDirection: ShipDirection.Down, start: (9, 5), size: 3),
    Sheep(shipDirection: ShipDirection.Right, start: (0, 7), size: 2),
    Sheep(shipDirection: ShipDirection.Right, start: (4, 9), size: 5)
];

let game = Game(sheeps: sheeps, gameHandler: GameWritter());

while (!game.isWin()) {
    print("\nEnter column name ('A' ... 'J'):", terminator: " ");
    let col = Int(((Character(readLine() ?? "")).asciiValue ?? 65) - 65);
    
    print("Enter row number (1 ... 10):", terminator: " ");
    let row = (Int(readLine() ?? "") ?? 1) - 1;
    
    game.makeStep(row: row, col: col);
}
