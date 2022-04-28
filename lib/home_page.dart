import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool canPlay = true;
  double wid = 5;
  bool isCross = true;
  String? message;
  List<String>? gameState;
  AssetImage cross = const AssetImage('images/cross.png');
  AssetImage circle = const AssetImage('images/circle.png');
  AssetImage edit = const AssetImage('images/edit.png');
  @override
  void initState() {
    super.initState();
    setState(() {
      gameState = [
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
      ];
      message = "";
    });
  }

  resetgame() {
    setState(() {
      canPlay = true;
      gameState = [
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
      ];
      message = "";
    });
  }

  AssetImage getimage(String value) {
    switch (value) {
      case 'empty':
        return edit;

      case 'cross':
        return cross;

      case 'circle':
        return circle;

      default:
        return edit;
    }
  }

  playgame(int index) {
    if (canPlay) {
      if (gameState![index] == "empty") {
        setState(() {
          if (isCross == true) {
            gameState![index] = "cross";
          } else {
            gameState![index] = "circle";
          }
          isCross = !isCross;
          checkWin();
        });
      }
    }
  }

  checkWin() {
    if (gameState![0] != 'empty' &&
        gameState![0] == gameState![1] &&
        gameState![1] == gameState![2]) {
      setState(() {
        message = '${gameState![0]} wins';
        wid = 20;
        canPlay = false;
      });
    } else if (gameState![0] != 'empty' &&
        gameState![3] == gameState![6] &&
        gameState![0] == gameState![3]) {
      setState(() {
        message = '${gameState![0]} wins';
        wid = 20;
        canPlay = false;
      });
    } else if (gameState![3] != 'empty' &&
        gameState![3] == gameState![4] &&
        gameState![4] == gameState![5]) {
      setState(() {
        message = '${gameState![3]} wins';
        wid = 20;
        canPlay = false;
      });
    } else if (gameState![6] != 'empty' &&
        gameState![6] == gameState![7] &&
        gameState![7] == gameState![8]) {
      setState(() {
        message = '${gameState![6]} wins';
        wid = 20;
        canPlay = false;
      });
    } else if (gameState![1] != 'empty' &&
        gameState![1] == gameState![4] &&
        gameState![4] == gameState![7]) {
      setState(() {
        message = '${gameState![1]} wins';
        wid = 20;
        canPlay = false;
      });
    } else if (gameState![2] != 'empty' &&
        gameState![2] == gameState![5] &&
        gameState![5] == gameState![8]) {
      setState(() {
        message = '${gameState![2]} wins';
        wid = 20;
        canPlay = false;
      });
    } else if (gameState![0] != 'empty' &&
        gameState![0] == gameState![4] &&
        gameState![4] == gameState![8]) {
      setState(() {
        message = '${gameState![0]} wins';
        wid = 20;
        canPlay = false;
      });
    } else if (gameState![2] != 'empty' &&
        gameState![2] == gameState![4] &&
        gameState![4] == gameState![6]) {
      setState(() {
        message = '${gameState![2]} wins';
        wid = 20;
        canPlay = false;
      });
    } else if (!gameState!.contains("empty")) {
      setState(() {
        message = 'Draw';
        wid = 20;
        canPlay = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("TikTaeToe",
            style: GoogleFonts.lato(fontStyle: FontStyle.normal)),
        backgroundColor: Colors.transparent,
        toolbarHeight: 70,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              gradient: LinearGradient(
                  colors: [Colors.lightGreenAccent, Colors.redAccent],
                  begin: Alignment.bottomRight,
                  end: Alignment.topCenter)),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // important to use EXPANDED for gridView
            Expanded(
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.0,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                  ),
                  itemCount: gameState!.length,
                  itemBuilder: (context, i) {
                    return SizedBox(
                      height: 10,
                      width: 10,
                      child: MaterialButton(
                        onPressed: () {
                          playgame(i);
                        },
                        child: Image(image: getimage(gameState![i])),
                      ),
                    );
                  }),
            ),
            Row(
              //  mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedContainer(
                  width: 60,
                  height: 50,
                  duration: const Duration(seconds: 6),
                  margin: const EdgeInsets.only(
                      bottom: 80, top: 10, left: 140, right: 10),
                  child: Text(
                    message!,
                    style: TextStyle(
                        color: message == 'cross wins'
                            ? Colors.red.withOpacity(0.7)
                            : Colors.green.withOpacity(0.7),
                        fontSize: wid,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: resetgame,
              child: Text('Reset'),
              style: ElevatedButton.styleFrom(
                primary: Colors.red.withOpacity(0.8),
                fixedSize: const Size(80, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // <-- Radius
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
