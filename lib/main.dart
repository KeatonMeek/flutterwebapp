import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:webapp/models/anagram_model.dart';
import 'package:webapp/other_main/other_main.dart';
import 'package:webapp/services/anagram_service.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[800],
        primarySwatch: Colors.blue,
      ),
      // home: const MainPage(),
      home: const OtherMain(),
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
  List<String>? values;
  bool isLoaded = false;
  AnagramModel? anagram;

  //gets anagram data and stores it in the returnText and values variables for use
  Future<void> getAnagramData(String text) async {
    //calls the anagram functio nand stores the anagram return into the anagramModel object
    anagram = await AnagramService().getAnagram(text);
    setState(() {
      //checks to see if the values are null. otherwise adds the values to the variables
      if (anagram?.letters != null && anagram?.words != null) {
        //adds the values to the variables
        returnText = anagram!.letters;
        values = anagram!.words;
        isLoaded = true;
      }
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
          AnagramInput(getAnagramData),
          Text(returnText),

          /* USING A TEXT WIDGET WITH A COMMA DELIMITED RESULT */
          // Visibility(
          //   visible: values != null && values!.isNotEmpty,
          //   child: Text(values?.join(', ') ?? '')
          // )

          /* USING WRAP AND CARDS */
          // if (values != null)
          //   Wrap(
          //     children: values!.map((e) => Card(child: Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: Text(e),
          //     ))).toList(),
          //   )

          /* USING LISTVIEW */
          // note the expanded widget here is required, see: https://stackoverflow.com/questions/45669202/how-to-add-a-listview-to-a-column-in-flutter
          // if (values != null)
          //   Expanded(
          //     child: ListView.builder(
          //       itemCount: values!.length,
          //       itemBuilder: (_, index) {
          //         return Card(
          //           child: Padding(
          //             padding: const EdgeInsets.all(8),
          //             child: Text(values![index]),
          //           ),
          //         );
          //       },
          //     ),
          //   )

          /* USING SINGLECHIDLSCROLLVIEW */
          // if (values != null)
          //   Expanded(
          //     child: SingleChildScrollView(
          //       child: Column(
          //         children: values!.map((e) => Card(
          //           child: Padding(
          //             padding: const EdgeInsets.all(8),
          //             child: Text(e),
          //           ),
          //         )).toList(),
          //       ),
          //     ),
          //   )
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
