import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/usecases/is_user_logged_in_usecase.dart';
import '../../../domain/usecases/read_user_auth_usecase.dart';
import 'settings_events.dart';
import 'settings_states.dart';

@injectable
class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc(
      this._isUserLoggedInUseCase, this._readUserAuthUseCase, initialState)
      : super(initialState);

  final IsUserLoggedInUseCase _isUserLoggedInUseCase;
  final ReadUserAuthUseCase _readUserAuthUseCase;
}
