import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sleep_giant/helper/user_repository.dart';
import 'package:sleep_giant/helper/validators.dart';


import 'sign_up_event.dart';
import 'sign_up_state.dart';

/**
 * Need to extend Bloc, implement [initialState], and [mapEventToState].
 * Optionally, we are overriding [transform] again so that we can give users some
 * time to finish typing before we validate the form.
 */
///

class SGSignUpBloc extends Bloc<SGSignUpEvent, SGSignUpState> {
  final UserRepository _userRepository;

  SGSignUpBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  SGSignUpState get initialState => SGSignUpState.empty();

  @override
  Stream<SGSignUpState> transform(
    Stream<SGSignUpEvent> events,
    Stream<SGSignUpState> Function(SGSignUpEvent event) next,
  ) {
    final observableStream = events as Observable<SGSignUpEvent>;
    final nonDebounceStream = observableStream.where((event) {
      return (event is! EmailChanged && event is! PasswordChanged);
    });
    final debounceStream = observableStream.where((event) {
      return (event is EmailChanged || event is PasswordChanged);
    }).debounceTime(Duration(milliseconds: 300));
    return super.transform(nonDebounceStream.mergeWith([debounceStream]), next);
  }

  @override
  Stream<SGSignUpState> mapEventToState(
    SGSignUpEvent event,
  ) async* {
    if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is Submitted) {
      yield* _mapFormSubmittedToState(event.email, event.password);
    }
  }

  Stream<SGSignUpState> _mapEmailChangedToState(String email) async* {
    yield currentState.update(
      isEmailValid: Validators.isValidEmail(email),
    );
  }

  Stream<SGSignUpState> _mapPasswordChangedToState(String password) async* {
    yield currentState.update(
      isPasswordValid: Validators.isValidPassword(password),
    );
  }

  Stream<SGSignUpState> _mapFormSubmittedToState(
    String email,
    String password,
  ) async* {
    yield SGSignUpState.loading();
    try {
      await _userRepository.signUp(
        email: email,
        password: password,
      );
      yield SGSignUpState.success();
    } catch (_) {
      yield SGSignUpState.failure();
    }
  }
}
