import 'package:flutter/material.dart';
import 'win_screen.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

bool player1 = true;
List usedContainers = [];
List player1Containers = [];
List player2Containers = [];
List winningCombinations = [
  [1, 2, 3],
  [4, 5, 6],
  [7, 8, 9],
  [1, 4, 7],
  [2, 5, 8],
  [3, 6, 9],
  [1, 5, 9],
  [3, 5, 7],
];

void resetGame() {
  usedContainers = [];
  player1Containers = [];
  player2Containers = [];
  player1 = true;
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tic Tac Test')),
      body: ListView(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GameContainer(
                containerID: 1,
              ),
              GameContainer(
                containerID: 2,
              ),
              GameContainer(
                containerID: 3,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GameContainer(
                containerID: 4,
              ),
              GameContainer(
                containerID: 5,
              ),
              GameContainer(
                containerID: 6,
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GameContainer(
                containerID: 7,
              ),
              GameContainer(
                containerID: 8,
              ),
              GameContainer(
                containerID: 9,
              )
            ],
          )
        ],
      ),
    );
  }
}

class GameContainer extends StatefulWidget {
  GameContainer({this.containerID});
  final int containerID;
  @override
  _GameContainerState createState() => _GameContainerState();
}

class _GameContainerState extends State<GameContainer> {
  void checkWinner(player) {
    for (var _combo in winningCombinations) {
      int _comboHits = 0;
      for (var x in _combo) {
        if (player == 1) {
          if (player1Containers.contains(x)) {
            _comboHits++;
          }
        } else {
          if (player2Containers.contains(x)) {
            _comboHits++;
          }
        }
        if (_comboHits == 3) {
          resetGame();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return WinScreen(
                  winner: player,
                );
              },
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (usedContainers.contains(widget.containerID)) {
//          do nothing if container is already used
        } else {
          if (player1) {
            setState(() {
              usedContainers.add(widget.containerID);
              player1Containers.add(widget.containerID);
              player1 = false;
            });
            checkWinner(1);
          } else {
            setState(() {
              usedContainers.add(widget.containerID);
              player2Containers.add(widget.containerID);
              player1 = true;
            });
            checkWinner(2);
          }
        }
//        Checks for draw
        if (usedContainers.length == 9) {
          resetGame();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return WinScreen(
                  winner: 0,
                );
              },
            ),
          );
        }
      },
      child: Container(
        margin: EdgeInsets.all(20.0),
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                  color: Colors.blueGrey,
                  offset: Offset(7.0, 5.0),
                  blurRadius: 3.0)
            ]),
        child: Icon(
          usedContainers.contains(widget.containerID)
              ? player1Containers.contains(widget.containerID)
                  ? Icons.close
                  : Icons.change_history
              : Icons.help,
          color: Colors.white,
          size: 40.0,
        ),
      ),
    );
  }
}
