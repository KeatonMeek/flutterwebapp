import 'package:flutter/material.dart';
import 'package:webapp/models/anagram_model.dart';

class AnagramData {
  final String _letter = "";
  var _anagramData = <int, List<String>>{};

  int words(ValueNotifier<AnagramModel?> anagramsResult) {
    int counter = 0;
    String previousWord = "";
    String currentWord = "";

    for (var i = 0; i < anagramsResult.value!.words.length; i++) {
      currentWord = anagramsResult.value!.words[i];

      if (previousWord != "") {
        //print("yep");
        if (currentWord.length == previousWord.length) {
          counter++;
          currentWord = previousWord;
        }
      } else {
        previousWord = currentWord;
        counter++;
      }
      print(currentWord);
    }

    //print(anagramsResult.value!.words.length);
    print(counter);
    return counter;
  }

  String letter(ValueNotifier<AnagramModel?> anagramsResult) {
    return anagramsResult.value!.letters;
    //return anagrams;
  }
}
