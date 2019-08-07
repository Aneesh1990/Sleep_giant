import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sleep_giant/helper/authentication_bloc/bloc.dart';
import 'package:sleep_giant/helper/bloc_delegate.dart';
import 'package:sleep_giant/helper/user_repository.dart';
import 'package:sleep_giant/screens/home/home_screen.dart';
import 'package:sleep_giant/screens/sign_in/sign_in.dart';
import 'package:sleep_giant/screens/splash/splash_screen.dart';


void main() {
  BlocSupervisor.delegate = SGBlocDelegate();
  final UserRepository userRepository = UserRepository();
  runApp(
    BlocProvider(
      builder: (context) => AuthenticationBloc(userRepository: userRepository)
        ..dispatch(AppStarted()),
      child: SleepGiantApp(userRepository: userRepository),
    ),
  );
}

class SleepGiantApp extends StatelessWidget {
  final UserRepository _userRepository;

  SleepGiantApp({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is Unauthenticated) {
            return SGSignInScreen(userRepository: _userRepository);
          }
          if (state is Authenticated) {
            return HomeScreen(name: state.displayName);
          }
          return SplashScreen();
        },
      ),
    );
  }
}
