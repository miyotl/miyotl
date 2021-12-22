import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_events.freezed.dart';

@freezed
class SettingsEvent with _$SettingsEvent {
  const factory SettingsEvent.languageChange(String languageSelected) =
      LanguageChange;

  const factory SettingsEvent.logOut() = LogOut;

  const factory SettingsEvent.enableCollaboration() = EnableCollaboration;
}
