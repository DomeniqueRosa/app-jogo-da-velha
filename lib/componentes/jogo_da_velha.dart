
import 'package:flutter/material.dart';

class JogoDaVelha extends StatefulWidget {
  const JogoDaVelha({super.key});

  @override
  State<JogoDaVelha> createState() => _JogoDaVelhaState();
}

class _JogoDaVelhaState extends State<JogoDaVelha> {
  late List<String> _board;
  late String _currentPlayer;
  late String _winner;
  late bool _gameOver;

  @override
  void initState() {
    super.initState();
    _initializeGame();
  }

  void _initializeGame() {
    _board = List.generate(9, (_) => "");
    _currentPlayer = "X";
    _winner = "";
    _gameOver = false;
  }

  void _makeMove(int index) {
    if (_gameOver || _board[index].isNotEmpty) return;

    setState(() {
      _board[index] = _currentPlayer;
      _checkWinner();
      _togglePlayer();
    });
  }

  void _checkWinner() {
    // Check rows
    for (int i = 0; i < 9; i += 3) {
      if (_board[i].isNotEmpty &&
          _board[i] == _board[i + 1] &&
          _board[i] == _board[i + 2]) {
        _winner = _board[i];
        _gameOver = true;
        return;
      }
    }

    // Check columns
    for (int i = 0; i < 3; i++) {
      if (_board[i].isNotEmpty &&
          _board[i] == _board[i + 3] &&
          _board[i] == _board[i + 6]) {
        _winner = _board[i];
        _gameOver = true;
        return;
      }
    }

    // Check diagonals
    if (_board[0].isNotEmpty &&
        _board[0] == _board[4] &&
        _board[0] == _board[8]) {
      _winner = _board[0];
      _gameOver = true;
      return;
    }
    if (_board[2].isNotEmpty &&
        _board[2] == _board[4] &&
        _board[2] == _board[6]) {
      _winner = _board[2];
      _gameOver = true;
      return;
    }

    // Check for a tie
    if (!_board.contains("")) {
      _gameOver = true;
      _winner = "Tie";
    }
  }

  void _togglePlayer() {
    _currentPlayer = _currentPlayer == "X" ? "O" : "X";
  }

  void _resetGame() {
    setState(() {
      _initializeGame();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jogo da Velha'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: 9,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => _makeMove(index),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color.fromARGB(255, 83, 2, 40)),
                    ),
                    child: Center(
                      child: Text(
                        _board[index],
                        style: const TextStyle(fontSize: 48),
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            if (_gameOver)
              Text(
                _winner == "Tie" ? "Empate!" : "Vencedor: $_winner",
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            if (_gameOver)
              ElevatedButton(
                onPressed: _resetGame,
                child: const Text("Jogar Novamente"),
              ),
          ],
        ),
      ),
    );
  }
}
