import 'package:flutter/material.dart';
import 'package:xo_game_app/shared/componetns/components.dart';
import 'package:xo_game_app/shared/componetns/game_logic.dart';
import 'package:xo_game_app/shared/componetns/game_logic.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _onTap(int index) async {


    if ((Player.playerX.isEmpty ||
        !Player.playerX.contains(index)) &&
        (Player.playerO.isEmpty ||
        !Player.playerO.contains(index))) {
      game.playGame(index, activePlayer);
      updateState();

      if( ! isSwitched && ! gameOver && turn != 9){
         await game.autoPlay(activePlayer);
         updateState();
      }
    }
  }

  void updateState() {
    setState(() {
      activePlayer = activePlayer == 'X' ? 'O' : 'X';
      turn ++ ;
      String winnerPlayer = game.checkWinner();

      if(winnerPlayer != '')
      {
        gameOver =true;
        result = '$winnerPlayer is the winner';
      }
      else if( ! gameOver && turn == 9 )
        {
          result = 'it\'s Draw';
        }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        child: SafeArea(
          child: Column(
            children: [
              SwitchListTile.adaptive(
                  title: Text(
                    'Turn on \ off two player',
                    style: TextStyle(
                      fontSize: 24,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  value: isSwitched,
                  onChanged: (bool newValue) {
                    setState(() {
                      isSwitched = newValue;
                    });
                  }),
              SizedBox(
                height: 10,
              ),
              Text(
                'It\'s  $activePlayer  turn'.toUpperCase(),
                style: TextStyle(
                  fontSize: 48,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: GridView.count(
                  physics: ScrollPhysics(),
                  crossAxisCount: 3,
                  padding: EdgeInsets.all(15),
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                  childAspectRatio: 1.0,
                  children: List.generate(
                    9,
                    (index) => InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: gameOver ? null : () => _onTap(index),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF001456),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: Text(
                            Player.playerX.contains(index)
                                ? 'X'
                                : Player.playerO.contains(index)
                                    ? 'O'
                                    : "",
                            style: TextStyle(
                                color: Player.playerX.contains(index)
                                    ? Colors.blue
                                    : Colors.pinkAccent,
                                fontSize: 60),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Text(
                result,
                style: TextStyle(
                  fontSize: 32,
                ),
                textAlign: TextAlign.center,
              ),
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    Player.playerX = [];
                    Player.playerO = [];
                    activePlayer = 'X';
                    gameOver = false;
                    turn = 0;
                    result = ' ';
                  });
                },
                icon: Icon(Icons.replay),
                label: Text('Replay the game'.toUpperCase()),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).splashColor)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
