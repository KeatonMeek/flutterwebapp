import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
      home: const MainPage(),
    );
  }
}

//main page of the webapp
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String returnText = "";

  //updates the text on the screen when the button is clicked
  void updateText(String text) {
    setState(() {
      returnText = text;
    });
  }

  //sets up all the functionality of the webpage
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Anagram Calculator'),
      ),
      body: Column(
        children: <Widget>[
          //displays the input box and the elevated button
          //passes the text from the TextField and returns it to the webpage
          AnagramInput(updateText),
          Text(returnText),
        ],
      ),
    );
  }
}

//displays the textfield and the elevated button for the user
class AnagramInput extends StatefulWidget {
  //creates function to return the value input
  final Function(String) callback;
  //passes the value to the updateText Function
  AnagramInput(this.callback);

  @override
  State<AnagramInput> createState() => _AnagramInputState();
}

class _AnagramInputState extends State<AnagramInput> {
  //allows the button to retrieve the value of the text in the input field
  TextEditingController inputController = TextEditingController();

  //stores the value from the input field
  late String getValue = "";

  //cleanup resources after the value is stored from the string
  @override
  void dispose() {
    super.dispose();
    inputController.dispose();
  }

  //function that handles the click event to pass the value to the updateText function
  void click() {
    widget.callback(inputController.text);
    inputController.clear();
  }

  //builds the textfield and the elevated button
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: SizedBox(
            width: 500,
            child: TextField(
              controller: inputController,
              // ignore: prefer_const_constructors
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'Enter a word to produce anagrams',
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(150, 60),
              maximumSize: const Size(150, 60),
            ),
            child: const Text('Calculate'),
            onPressed: () {
              //calls the click function to return the value to the screen
              click();
            },
          ),
        ),
      ],
    );
  }
}
