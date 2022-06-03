import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:webapp/models/anagram_model.dart';
import 'package:webapp/other_main/other_main_model.dart';

/* We use this package in our main project called Riverpod/Hooks
 * The purpose of this is easier state management, less boilerplate, and better readability
 * In this file I'll rewrite your program in the way it would be done using these packages
 */
class OtherMain extends HookConsumerWidget {
  const OtherMain({Key? key}) : super(key: key);

  Future<void> _submit(OtherMainModel modelNotifier, TextEditingController inputController, ValueNotifier<AnagramModel?> anagramsResult) async {
    anagramsResult.value = await modelNotifier.getAnagramData(inputController.value.text);
    inputController.text = '';
  }

  Widget _buildAnagramInput(TextEditingController inputController, OtherMainModel modelNotifier, ValueNotifier<AnagramModel?> anagramsResult, {bool isLoading = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: SizedBox(
            width: 500,
            child: TextFormField(
              autofocus: true,
              controller: inputController,
              enabled: !isLoading,
              // this allows you to press enter on your keyboard and submit the form
              onEditingComplete: () async => await _submit(modelNotifier, inputController, anagramsResult),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter a word to produce anagrams'
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: ElevatedButton(
            onPressed: isLoading ? null : () async => _submit(modelNotifier, inputController, anagramsResult),
            child: isLoading ? const CircularProgressIndicator() : const Text('Submit'),
          ),
        )
      ],
    );
  }

  Widget _buildAnagramsResult(ValueNotifier<AnagramModel?> anagramsResult) {
    if (anagramsResult.value == null) {
      return const SizedBox(height: 0, width: 0);
    } else {
      return Expanded(
        child: ListView.builder(
          itemCount: anagramsResult.value!.words.length,
          itemBuilder: (_, index) {
            final currentResult = anagramsResult.value!.words[index];

            return Card(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(currentResult),
              ),
            );
          },
        ),
      );
    }
  }

  Widget _buildContent(TextEditingController inputController, OtherMainModel modelNotifier, ValueNotifier<AnagramModel?> anagramsResult, {bool isLoading = false}) {
    return Column(
      children: [
        _buildAnagramInput(inputController, modelNotifier, anagramsResult, isLoading: isLoading),
        _buildAnagramsResult(anagramsResult)
      ],
    );
  }

  @override
  Widget build(context, ref) {
    final modelNotifier = ref.watch(otherMainModelProvider.notifier);
    final pageState = ref.watch(otherMainModelProvider);
    final inputController = useTextEditingController();
    final anagramsResult = useState<AnagramModel?>(null);

    return Scaffold(
      body: pageState.when(
        initial: () => _buildContent(inputController, modelNotifier, anagramsResult),
        loading: () => _buildContent(inputController, modelNotifier, anagramsResult, isLoading: true),
        error: (errText) => Text(errText)
      )
    );
  }
}