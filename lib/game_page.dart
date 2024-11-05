import 'package:flutter/material.dart';
import 'app_database.dart'; 

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  static const String PLAYER_X = "X";
  static const String PLAYER_Y = "O";

  late String currentPlayer;
  late bool gameEnd;
  late List<String> occupied = ["", "", "", "", "", "", "", "", ""];
  final AppDatabase _database = AppDatabase();

  @override
  void initState() {
    initializeGame();
    super.initState();
  }

  void initializeGame() {
    currentPlayer = PLAYER_X;
    gameEnd = false;
    occupied = ["", "", "", "", "", "", "", "", ""];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _headerText(),
            _gameContainer(),
            _restartButton(),
          ],
        ),
      ),
    );
  }

  Widget _headerText() {
    return Column(
      children: [
        const Text(
          "Rhaast Vs Kayn",
          style: TextStyle(
            color: Colors.red,
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "Vez de $currentPlayer",
          style: const TextStyle(
            color: Colors.blue,
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _gameContainer() {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      width: MediaQuery.of(context).size.height / 2,
      margin: const EdgeInsets.all(8),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemCount: 9,
        itemBuilder: (context, index) {
          return _box(index);
        },
      ),
    );
  }

  Widget _box(int index) {
    return InkWell(
      onTap: () {
        if (gameEnd || occupied[index].isNotEmpty) {
          return;
        }

        setState(() {
          occupied[index] = currentPlayer;
          changeTurn();
          checkForWinner();
          checkForDraw();
        });
      },
      child: Container(
        color: occupied[index].isEmpty
            ? Colors.black26
            : occupied[index] == PLAYER_X
                ? Colors.blue
                : Colors.orange,
        margin: const EdgeInsets.all(8),
        child: Center(
          child: Text(
            occupied[index],
            style: const TextStyle(fontSize: 50),
          ),
        ),
      ),
    );
  }

  Widget _restartButton() {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          initializeGame();
        });
      },
      child: const Text("Reiniciar Game"),
    );
  }

  void changeTurn() {
    currentPlayer = (currentPlayer == PLAYER_X) ? PLAYER_Y : PLAYER_X;
  }

  void checkForWinner() {
    List<List<int>> winningList = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var winningPos in winningList) {
      String playerPosition0 = occupied[winningPos[0]];
      String playerPosition1 = occupied[winningPos[1]];
      String playerPosition2 = occupied[winningPos[2]];

      if (playerPosition2.isNotEmpty && playerPosition0 == playerPosition1 && playerPosition0 == playerPosition2) {
        showGameOverMessage("Vitória de $playerPosition0");
        gameEnd = true;
        _saveGameRecord(playerPosition0);
        return;
      }
    }
  }

  void checkForDraw() {
    if (gameEnd) {
      return;
    }
    bool draw = true;
    for (var occupiedPlayer in occupied) {
      if (occupiedPlayer.isEmpty) {
        draw = false;
      }
    }

    if (draw) {
      showGameOverMessage("Draw");
      gameEnd = true;
    }
  }

  void showGameOverMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.purple,
        content: Text(
          "It's Over\n$message",
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  Future<void> _saveGameRecord(String winner) async {
    final record = GameRecord(
      id: 1,
      playerX: PLAYER_X,
      playerY: PLAYER_Y,
      winner: winner,
    );
    await _database.insertGameRecord(record);
  }
}
