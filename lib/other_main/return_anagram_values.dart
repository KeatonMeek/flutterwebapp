import 'package:flutter/material.dart';
import 'package:webapp/models/anagram_model.dart';

class AnagramData {
  final String _letter = "";
  var _anagramData = <int, List<String>>{};

  int words(ValueNotifier<AnagramModel?> anagramsResult) {
    int currentLength = 0;
    int previousLength = 0;
    int wordCount = 0;
    List<String> words = List<String>.empty(growable: true);

    for (var i = 0; i < anagramsResult.value!.words.length; i++) {
      currentLength = anagramsResult.value!.words[i].length;

      if (previousLength != currentLength) {
        wordCount = i;
        for (var j = i - wordCount; j < i; j++) {
          words.add(anagramsResult.value!.words[j]);
        }
        print(words);
      }

      previousLength = currentLength;
    }
    //print(words);
    return 2;
  }

  String letter(ValueNotifier<AnagramModel?> anagramsResult) {
    return anagramsResult.value!.letters;
    //return anagrams;
  }
}
