import 'package:flutter/material.dart';
import 'MatchCard.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Card Stack'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;  

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> cardList;

  void _removeCard(index) {
    setState(() {
      cardList.removeAt(index);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cardList = _getMatchCard();
  }

  double screenWidth;
  double cardMargin = 20;

  @override
  Widget build(BuildContext context) {    
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center (
        child: Stack(
          alignment: Alignment.center,
          children: cardList,        
        ),
      ),
    );
  }  

  List<Widget> _getMatchCard() {
  List<MatchCard> cards = new List();
  cards.add(MatchCard('card1','text1','imgUrl'));
  cards.add(MatchCard('card2','text3','imgUrl'));
  cards.add(MatchCard('card3','text3','imgUrl'));
  
  List<Widget> cardList = new List();
  String abc = "";

  for (int x = 0; x < 3; x++) {
    cardList.add(Positioned(        
      top: cardMargin * x,      
      child: SafeArea (
        child: Draggable(
          axis: Axis.horizontal,
          onDragEnd: (drag){            
            //print(drag.offset.distance);
            //print(drag.offset.direction);    
            abc = cards[x].title;
            print('screen width: $screenWidth');
            print('screen mid: ${screenWidth / 2}');
            double rightBoundary = ((screenWidth / 2) + (0.1 * (screenWidth - 150)));
            double leftBoundary = ((screenWidth / 2) - (0.25 * (screenWidth + 150)));
            print('left boundary: $leftBoundary');
            print('right boundary: $rightBoundary');
            print ('dropped distance: ${drag.offset.distance}');
            print ('dropped dx: ${drag.offset.dx}');            
            // print(dragProportion);
            //print(cardList.length);
            if(drag.offset.dx < leftBoundary) {              
              print("Swipe left");
              _removeCard(x);
            } else if (drag.offset.dx > rightBoundary) {
              print("Swipe right");
              _removeCard(x);
            } else {
              print("not enough action");
            }              
          },
          childWhenDragging: Container(),
          feedback: Card(
            elevation: 12,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Container (                
              width: 400,
              height: 450.0,
              padding: const EdgeInsets.all(20.0),
              // decoration: BoxDecoration(
              //   image: DecorationImage(
              //     image: AssetImage("images/bg1.jpg"),
              //     fit: BoxFit.fitWidth,
              //     alignment: Alignment.topCenter,
              //   ),
              // ),              
              child: Column (
                children: [                                        
                  Image (
                    image: AssetImage('images/bg1.jpg')
                  ),
                  Spacer(),
                  Text (
                    'Ipsative Question 1',
                    style: TextStyle(
                      fontFamily: 'Source Sans Pro',
                      color: Colors.teal,
                      fontSize: 20.0,
                      letterSpacing: 2.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),                  
                  Text (
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ac tincidunt vitae semper quis. Dictum varius duis at consectetur. Fusce ut placerat orci nulla.'
                  ),
                  Spacer(),
                ]
              ),
            ),
          ),
          child: Card(
            elevation: 12,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Container (                
              width: 400,
              height: 450.0,
              padding: const EdgeInsets.all(20.0),
              // decoration: BoxDecoration(
              //   image: DecorationImage(
              //     image: AssetImage("images/bg1.jpg"),
              //     fit: BoxFit.fitWidth,
              //     alignment: Alignment.topCenter,
              //   ),
              // ),              
              child: Column (
                children: [                                        
                  Image (
                    image: AssetImage('images/bg1.jpg')
                  ),
                  Spacer(),
                  Text (
                    'Ipsative Question 1',
                    style: TextStyle(
                      fontFamily: 'Source Sans Pro',
                      color: Colors.teal,
                      fontSize: 20.0,
                      letterSpacing: 2.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),                  
                  Text (
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ac tincidunt vitae semper quis. Dictum varius duis at consectetur. Fusce ut placerat orci nulla.'
                  ),
                  Spacer(),
                ]
              ),
            ),
          ),
        )
      ),
    ));
  }

    return cardList;
  }
}