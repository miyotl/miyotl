
import 'package:freezed_annotation/freezed_annotation.dart';
part 'settings_states.freezed.dart';

@freezed
class SettingsState with _$SettingsState {
  const factory SettingsState({ required bool isCollabEnabled, }) = _SettingsState;
}
