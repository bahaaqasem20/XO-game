import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xo_game/constants/colors.dart';
import 'dart:async';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int oScore = 0;
  int xScore = 0;
  int filledBoxes = 0;
  bool winnerFound = false;
  int attempts = 0;

  static const maxSecond = 30;
  int seconds = maxSecond;
  // the Timer dataType its from dart:async library
  Timer? timer;

  bool onTurn = true;
  String resultDeclaration = '';
  List<String> displayChoices = [
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
  ];
  List<int> matchedIndexes = [];
  static var customFontWhite = GoogleFonts.coiny(
      textStyle:
          TextStyle(color: Colors.white, letterSpacing: 3, fontSize: 28));

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() {
        if (seconds > 0) {
          seconds--;
        } else {
          stopTimer();
        }
      });
    });
  }

  void stopTimer() {
    resetTimer();
    timer?.cancel();
  }

  void resetTimer() => seconds = maxSecond;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainColors.primaryColor,
      // appBar: AppBar(title: Text("Game")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
                flex: 1,
                child: Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("PlayerO", style: customFontWhite),
                            Text(oScore.toString(), style: customFontWhite)
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("PlayerX", style: customFontWhite),
                            Text(xScore.toString(), style: customFontWhite)
                          ],
                        )
                      ],
                    ))),
            Expanded(
                flex: 3,
                child: GridView.builder(
                  itemCount: 9,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () {
                          _tapped(index);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                  width: 5, color: MainColors.primaryColor),
                              color: matchedIndexes.contains(index)
                                  ? MainColors.accentColor
                                  : MainColors.secondaryColor),
                          child: Center(
                            child: Text(displayChoices[index],
                                style: GoogleFonts.coiny(
                                    textStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 64,
                                        color: MainColors.primaryColor))),
                          ),
                        ));
                  },
                )),
            Expanded(
              flex: 2,
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(resultDeclaration, style: customFontWhite),
                  SizedBox(height: 10),
                  _buildTimer()
                ],
              )),
            ),
          ],
        ),
      ),
    );
  }

  void _tapped(int index) {
    final isRunning = timer == null ? false : timer!.isActive;

    if (isRunning) {
      setState(() {
        if (onTurn && displayChoices[index] == '') {
          displayChoices[index] = 'O';
          filledBoxes++;
        } else if (!onTurn && displayChoices[index] == '') {
          displayChoices[index] = 'X';
          filledBoxes++;
        }

        onTurn = !onTurn;
        checkWinner();
      });
    }
  }

  void checkWinner() {
    // check 1rd row
    if (displayChoices[0] == displayChoices[1] &&
        displayChoices[0] == displayChoices[2] &&
        displayChoices[0] != '') {
      setState(() {
        resultDeclaration = "Player" + displayChoices[0] + ' Wins!';
        matchedIndexes.addAll([0, 1, 2]);
        stopTimer();
        _updateScore(displayChoices[0]);
      });
    }

    // check 2rd row
    if (displayChoices[3] == displayChoices[4] &&
        displayChoices[3] == displayChoices[5] &&
        displayChoices[3] != '') {
      setState(() {
        resultDeclaration = "Player" + displayChoices[3] + ' Wins!';
        matchedIndexes.addAll([3, 4, 5]);
        stopTimer();
        _updateScore(displayChoices[3]);
      });
    }

    // check 3rd row
    if (displayChoices[6] == displayChoices[7] &&
        displayChoices[6] == displayChoices[8] &&
        displayChoices[6] != '') {
      setState(() {
        resultDeclaration = "Player" + displayChoices[6] + ' Wins!';
        matchedIndexes.addAll([6, 7, 8]);
        stopTimer();
        _updateScore(displayChoices[6]);
      });
    }

    // check 1rd column
    if (displayChoices[0] == displayChoices[3] &&
        displayChoices[0] == displayChoices[6] &&
        displayChoices[0] != '') {
      setState(() {
        resultDeclaration = "Player" + displayChoices[0] + ' Wins!';
        matchedIndexes.addAll([0, 3, 6]);
        stopTimer();
        _updateScore(displayChoices[0]);
      });
    }

    // check 2rd column
    if (displayChoices[1] == displayChoices[4] &&
        displayChoices[1] == displayChoices[7] &&
        displayChoices[1] != '') {
      setState(() {
        resultDeclaration = "Player" + displayChoices[1] + ' Wins!';
        matchedIndexes.addAll([1, 4, 7]);
        stopTimer();
        _updateScore(displayChoices[1]);
      });
    }

    // check 3rd column
    if (displayChoices[2] == displayChoices[5] &&
        displayChoices[2] == displayChoices[8] &&
        displayChoices[2] != '') {
      setState(() {
        resultDeclaration = "Player" + displayChoices[2] + ' Wins!';
        matchedIndexes.addAll([2, 5, 8]);
        stopTimer();
        _updateScore(displayChoices[2]);
      });
    }

    // check diagonal
    if (displayChoices[0] == displayChoices[4] &&
        displayChoices[0] == displayChoices[8] &&
        displayChoices[0] != '') {
      setState(() {
        resultDeclaration = "Player" + displayChoices[0] + ' Wins!';
        matchedIndexes.addAll([0, 4, 8]);
        stopTimer();
        _updateScore(displayChoices[0]);
      });
    }

    if (displayChoices[2] == displayChoices[4] &&
        displayChoices[2] == displayChoices[6] &&
        displayChoices[2] != '') {
      setState(() {
        resultDeclaration = "Player" + displayChoices[2] + ' Wins!';
        matchedIndexes.addAll([2, 4, 6]);
        stopTimer();
        _updateScore(displayChoices[2]);
      });
    }
    if (!winnerFound && filledBoxes == 9) {
      setState(() {
        resultDeclaration = "Nobody Wins!";
        stopTimer();
      });
    }
  }

  void _updateScore(String winner) {
    if (winner == 'O') {
      oScore++;
    } else if (winner == 'X') {
      xScore++;
    }
    winnerFound = true;
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayChoices[i] = '';
      }
      resultDeclaration = '';
    });
    filledBoxes = 0;
  }

  Widget _buildTimer() {
    final isRunning = timer == null ? false : timer!.isActive;
    return isRunning
        ? SizedBox(
            width: 100,
            height: 100,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: 1 - seconds / maxSecond,
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                  strokeWidth: 8,
                  backgroundColor: MainColors.accentColor,
                ),
                Center(
                  child: Text(
                    "$seconds",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 50),
                  ),
                )
              ],
            ))
        : ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16)),
            onPressed: () {
              startTimer();
              _clearBoard();
              attempts++;
            },
            child: Text(
              attempts == 0 ? 'Play' : "Paly Again",
              style: TextStyle(fontSize: 20, color: Colors.black),
            ));
  }
}
