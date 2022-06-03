import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:webapp/models/anagram_model.dart';
import 'package:webapp/other_main/other_main_state.dart';
import 'package:webapp/services/anagram_service.dart';

final anagramServiceProvider = Provider((ref) => AnagramService());

class OtherMainModel extends StateNotifier<OtherMainState> {
  OtherMainModel({ required this.anagramService }) : super(const OtherMainState.initial());

  final AnagramService anagramService;

  Future<AnagramModel> getAnagramData(String text) async {
    try {
      state = const OtherMainState.loading();
      final anagram = await anagramService.getAnagram(text);

      state = const OtherMainState.initial();
      return anagram;
    } catch (e) {
      state = OtherMainState.error(e.toString());
      rethrow;
    }
  }
}

final otherMainModelProvider = StateNotifierProvider<OtherMainModel, OtherMainState>((ref) {
  final anagramService = ref.read(anagramServiceProvider);

  return OtherMainModel(anagramService: anagramService);
});