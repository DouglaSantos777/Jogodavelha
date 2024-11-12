import 'dart:math';
import 'package:flutter/material.dart';
import 'app_database.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  static const String PLAYER_X = "Kayn";
  static const String PLAYER_Y = "Rhaast";

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
    body: Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/maxresdefault.jpg'),
          fit: BoxFit.cover,  
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _headerText(),
            _gameContainer(),
            _restartButton(),
            _scoreboard(),
          ],
        ),
      ),
    ),
  );
}

  Widget _headerText() {
    return Column(
      children: [
        RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: "Rhaast",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: " vs ",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: "Kayn",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Text(
          "Vez de $currentPlayer",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 30,
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
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
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
            ? Colors.black54
            : occupied[index] == PLAYER_X
                ? Colors.blue
                : Colors.red,
        margin: const EdgeInsets.all(8),
        child: Center(
          child: Center(
            child: occupied[index].isEmpty
                ? null
                : Image.asset(
                    occupied[index] == PLAYER_X
                        ? 'assets/images/kayn.png'
                        : 'assets/images/rhaast.png',
                    width: 50,
                    height: 50,
                  ),
          ),
        ),
      ),
    );
  }

  Widget _restartButton() {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      child: ElevatedButton(
      
        onPressed: () {
          setState(() {
            initializeGame();
          });
        },
      
        child:
         const Text("Reiniciar Game", 
         style: TextStyle(color: Colors.black)),
         
      ),
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

      if (playerPosition2.isNotEmpty &&
          playerPosition0 == playerPosition1 &&
          playerPosition0 == playerPosition2) {
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
      showGameOverMessage("Empate");
      gameEnd = true;
      _saveGameRecord("Empate");
    }
  }

  void showGameOverMessage(String message) {
  Color snackBarColor;
  if (message.contains("Kayn")) {
    snackBarColor = Colors.blue;
  } else if (message.contains("Rhaast")) {
    snackBarColor = Colors.red; 
  } else {
    snackBarColor = Colors.grey;
  }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: snackBarColor,
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
    final random = Random();
    final record = GameRecord(
      id: random.nextInt(1000000),
      playerX: PLAYER_X,
      playerY: PLAYER_Y,
      winner: winner,
    );
    await _database.insertGameRecord(record);
  }

  Widget _scoreboard() {
    return FutureBuilder<List<GameRecord>>(
      future: _database.getAllGameRecords(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Erro: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('Nenhuma partida registrada');
        } else {
          final records = snapshot.data!;
          int playerXWins =
              records.where((record) => record.winner == PLAYER_X).length;
          int playerYWins =
              records.where((record) => record.winner == PLAYER_Y).length;
          int draws =
              records.where((record) => record.winner == "Empate").length;

          return Container(
            margin: const EdgeInsets.only(top: 45),
            child: Column(
              children: [
                Text("Vitórias de $PLAYER_X: $playerXWins",
                    style: const TextStyle(fontSize: 18, color: Colors.white)),
                Text("Vitórias de $PLAYER_Y: $playerYWins",
                    style: const TextStyle(fontSize: 18, color: Colors.white)),
                Text("Empates: $draws", style: const TextStyle(fontSize: 18, color: Colors.white)),
              ],
            ),
          );
        }
      },
    );
  }
}
