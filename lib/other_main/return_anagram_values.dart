import 'package:flutter/material.dart';
import 'package:webapp/models/anagram_model.dart';

class AnagramData {
  final String _letter = "";
  List<String> allWords = List<String>.empty(growable: true);
  List<String> wordLengths = List<String>.empty(growable: true);

  /*
  Method that intakes all the values of the anagrams result from the api call
  and parses the words into specific word lengths to return back to the cards in the UI
  Also adds the total number of different word lengths to the wordLengths list to return to the cards in the UI
  */
  int words(ValueNotifier<AnagramModel?> anagramsResult) {
    //stores the current item, previous item, and allows me to build a string for specific word lengths
    String currentItem = "";
    String previousItem = "";
    StringBuffer words = StringBuffer();

    //loops through all of the anagram values returned from the api call
    for (String item in anagramsResult.value!.words) {
      //gets the current item
      currentItem = item;

      //checks if the previous item is empty and adds the current item to the stringbuffer if so
      if (previousItem.isEmpty) {
        words.write("$currentItem, ");
        //otherwise it checks if the lengths have changed between the previous word and the current word
      } else if (currentItem.length != previousItem.length) {
        //checks if the words stringbuffer is empty. if it isnt, it adds the words concatenated string to the allWords list to return to the UI
        if (words.toString().isNotEmpty) {
          allWords.add(words.toString().substring(0, words.length - 2));
          wordLengths.add(previousItem.length.toString());
        }

        words.clear();
        words.write("$currentItem, ");
        //if the word length hasn't changed, it continues to add the current word to the stringbufffer
      } else {
        words.write("$currentItem, ");
      }

      //sets previous word to current word
      previousItem = currentItem;
    }

    //catch all for missed values in the current loop to make sure they are added
    //shoddy code I know, but I couldn't figure out how to get them added during the loop runtime.
    wordLengths.add(previousItem.length.toString());
    allWords.add(words.toString().substring(0, words.length - 2));

    //returns length of the list that was built
    return allWords.length;
  }

  //returns the letters that the user was wanting to return anagrams for from the anagramapi call
  String letter(ValueNotifier<AnagramModel?> anagramsResult) {
    return anagramsResult.value!.letters;
    //return anagrams;
  }
}
