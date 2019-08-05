import 'package:flutter/material.dart';

class WinScreen extends StatefulWidget {
  WinScreen({this.winner});
  final int winner;
  @override
  _WinScreenState createState() => _WinScreenState();
}

class _WinScreenState extends State<WinScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Tic Tac Test')),
        body: Center(
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
              child: Text(
                widget.winner != 0
                    ? 'Player ${widget.winner} Wins !!!!!!!'
                    : 'Draw',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 50.0,
                    color: Colors.white),
              )),
        ));
  }
}
