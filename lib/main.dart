import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: TicTacToe(),
    );
  }
}

class TicTacToe extends StatefulWidget {
  const TicTacToe({super.key});

  @override
  TicTacToeState createState() => TicTacToeState();
}

class TicTacToeState extends State<TicTacToe> {
  late List<List<String>> _board;
  late String _currentPlayer;
  late String _winner;

  @override
  void initState() {
    super.initState();
    _resetGame();
  }

  void _resetGame() {
    setState(() {
      _board = List.generate(3, (_) => List.generate(3, (_) => ''));
      _currentPlayer = 'X';
      _winner = '';
    });
  }

  void _makeMove(int row, int col) {
    if (_board[row][col] == '' && _winner == '') {
      setState(() {
        _board[row][col] = _currentPlayer;
        if (_checkWinner(row, col)) {
          _winner = _currentPlayer;
        } else {
          _currentPlayer = _currentPlayer == 'X' ? 'O' : 'X';
        }
      });
    }
  }

  bool _checkWinner(int row, int col) {
    // Check row
    if (_board[row].every((cell) => cell == _currentPlayer)) {
      return true;
    }
    // Check column
    if (_board.every((row) => row[col] == _currentPlayer)) {
      return true;
    }
    // Check diagonals
    if (row == col &&
        _board.every((row) => row[_board.indexOf(row)] == _currentPlayer)) {
      return true;
    }
    if (row + col == 2 &&
        _board.every((row) => row[2 - _board.indexOf(row)] == _currentPlayer)) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jogo da Velha'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetGame,
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (int row = 0; row < 3; row++)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int col = 0; col < 3; col++)
                  GestureDetector(
                    onTap: () => _makeMove(row, col),
                    child: Container(
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple[50],
                        border: Border.all(color: Colors.deepPurple),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Center(
                        child: Text(
                          _board[row][col],
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: _board[row][col] == 'X'
                                ? Colors.deepPurple
                                : Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          if (_winner != '')
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Jogador $_winner venceu!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
