import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/sign_up_bloc.dart';
import 'sign_up_form.dart';
import 'package:sleep_giant/helper/user_repository.dart';


class SGSignUpScreen extends StatelessWidget {
  final UserRepository _userRepository;

  SGSignUpScreen({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocProvider<SGSignUpBloc>(
          builder: (context) => SGSignUpBloc(userRepository: _userRepository),
            child: Container(
                decoration:new BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage("assets/theme_bg.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              child: RegisterForm()),
        ),
      ),
    );
  }
}
