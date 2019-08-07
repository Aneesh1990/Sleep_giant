import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sleep_giant/helper/user_repository.dart';
import 'package:sleep_giant/helper/validators.dart';

import 'sign_in_event.dart';
import 'sign_in_state.dart';

/**
 * Need to extend Bloc and define our initialState as well as mapEventToState.
 * overriding transform in order to debounce the EmailChanged and
 * PasswordChanged events so that we give the user some time to stop typing
 * before validating the input.We are using a Validators class to validate the email and password
 */
///

class SGSignInBloc extends Bloc<SGSignInEvent, SGSignInState> {
  UserRepository _userRepository;

  SGSignInBloc({
    @required UserRepository userRepository,
  })  : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  SGSignInState get initialState => SGSignInState.empty();

  @override
  Stream<SGSignInState> transform(
    Stream<SGSignInEvent> events,
    Stream<SGSignInState> Function(SGSignInEvent event) next,
  ) {
    final observableStream = events as Observable<SGSignInEvent>;
    final nonDebounceStream = observableStream.where((event) {
      return (event is! EmailChanged && event is! PasswordChanged);
    });
    final debounceStream = observableStream.where((event) {
      return (event is EmailChanged || event is PasswordChanged);
    }).debounceTime(Duration(milliseconds: 300));
    return super.transform(nonDebounceStream.mergeWith([debounceStream]), next);
  }

  @override
  Stream<SGSignInState> mapEventToState(SGSignInEvent event) async* {
    if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is LoginWithGooglePressed) {
      yield* _mapLoginWithGooglePressedToState();
    } else if (event is LoginWithCredentialsPressed) {
      yield* _mapLoginWithCredentialsPressedToState(
        email: event.email,
        password: event.password,
      );
    }
  }

  Stream<SGSignInState> _mapEmailChangedToState(String email) async* {
    yield currentState.update(
      isEmailValid: Validators.isValidEmail(email),
    );
  }

  Stream<SGSignInState> _mapPasswordChangedToState(String password) async* {
    yield currentState.update(
      isPasswordValid: Validators.isValidPassword(password),
    );
  }

  Stream<SGSignInState> _mapLoginWithGooglePressedToState() async* {
    try {
      await _userRepository.signInWithGoogle();
      yield SGSignInState.success();
    } catch (_) {
      yield SGSignInState.failure();
    }
  }

  Stream<SGSignInState> _mapLoginWithCredentialsPressedToState({
    String email,
    String password,
  }) async* {
    yield SGSignInState.loading();
    try {
      await _userRepository.signInWithCredentials(email, password);
      yield SGSignInState.success();
    } catch (_) {
      yield SGSignInState.failure();
    }
  }
}
