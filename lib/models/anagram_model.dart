// To parse this JSON data, do
//
//     final anagramModel = anagramModelFromJson(jsonString);

import 'dart:convert';

AnagramModel anagramModelFromJson(String str) => AnagramModel.fromJson(json.decode(str));

String anagramModelToJson(AnagramModel data) => json.encode(data.toJson());

class AnagramModel {
    AnagramModel({
        required this.letters,
        required this.words,
    });

    String letters;
    List<String> words;

    factory AnagramModel.fromJson(Map<String, dynamic> json) => AnagramModel(
        letters: json["letters"],
        words: List<String>.from(json["words"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "letters": letters,
        "words": List<dynamic>.from(words.map((x) => x)),
    };
}
