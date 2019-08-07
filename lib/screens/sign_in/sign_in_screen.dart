import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sleep_giant/helper/user_repository.dart';
import 'package:sleep_giant/screens/sign_in/bloc/sign_in_bloc.dart';
import 'package:sleep_giant/screens/sign_in/sign_in_form.dart';

/***
 * we are extending StatefulWidget so that we can initialize the LoginBloc
 * in initState and dispose it in the dispose override.we are using BlocProvider
 * again in order to make the _signInBloc instance
 * available to all widgets within the sub-tree.
 * At this point, we need to implement the SignInForm widget which will be
 * responsible for displaying the form and submission buttons in order for a
 * user to authenticate .
 */
///


class SGSignInScreen extends StatelessWidget {
  final UserRepository _userRepository;

  SGSignInScreen({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: BlocProvider<SGSignInBloc>(
        builder: (context) => SGSignInBloc(userRepository: _userRepository),
        child: Container(
            decoration:new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/theme_bg.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: SGSignInForm(userRepository: _userRepository)
        ),
      ),
    );
  }
}
