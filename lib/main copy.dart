import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
     
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),

      body: StreamBuilder(
            stream: Firestore.instance.collection('tasks').snapshots(),
            builder: (context, snapshot) {
              if(snapshot.hasError) {
                return Text("Database error");
              } else if(!snapshot.hasData) {
                return Text('Loading Data... Please wait.');
              } else {
                return Card(
                  child: Draggable (
                    axis: Axis.horizontal,

                  ),
                  Column(
                    children: <Widget> [
                      ListTile(
                        leading: Icon(Icons.album, size: 50),
                        title:  Text(snapshot.data.documents[0]['title']),
                        subtitle: Text(snapshot.data.documents[0]['description'])
                      ),
                    ], 
                  ),                
                );
              }
            }
          ),        
      );
  }

}

class MatchCard { 
  int redColor = 0; 
  int greenColor = 0; 
  int blueColor = 0; 
  double margin = 0; 
  MatchCard(int red, int green, int blue, double marginTop) { 
    redColor = red; 
    greenColor = green; 
    blueColor = blue; 
    margin = marginTop; 
  }
}

List<Widget> _getMatchCard() { 
    List<MatchCard> cards = new List(); 
    cards.add(MatchCard(255, 0, 0, 10)); 
    cards.add(MatchCard(0, 255, 0, 20)); 
    cards.add(MatchCard(0, 0, 255, 30)); 
    List<Widget> cardList = new List(); 
   for (int x = 0; x < 3; x++) { 
     cardList.add(Positioned( 
       top: cards[x].margin, 
       child: Draggable( 
          onDragEnd: (drag){ 
            _removeCard(x); 
          }, 
       childWhenDragging: Container(), 
       feedback: Card( 
         elevation: 12, 
         color: Color.fromARGB(255, cards[x].redColor, cards[x].greenColor, cards[x].blueColor), 
         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), 
         child: Container( 
            width: 240, 
            height: 300, 
            ), 
          ), 
       child: Card( 
         elevation: 12, 
         color: Color.fromARGB(255, cards[x].redColor, cards[x].greenColor, cards[x].blueColor), 
         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), 
         child: Container( 
           width: 240, 
           height: 300, 
          ), 
         ), 
       ), 
     )
   ); 
  } 
  return cardList;
}

void _removeCard(index) { 
     setState(() { 
        cardList.removeAt(index); 
     }
  );
}