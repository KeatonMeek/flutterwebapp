import 'package:freezed_annotation/freezed_annotation.dart';

part 'other_main_state.freezed.dart';

@freezed
class OtherMainState with _$OtherMainState {
  const factory OtherMainState.initial() = _Initial;
  const factory OtherMainState.error(String errText) = _Error;
  const factory OtherMainState.loading() = _Loading;
}