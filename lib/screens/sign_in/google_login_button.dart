import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sleep_giant/screens/sign_in/bloc/sign_in_event.dart';

import 'bloc/sign_in_bloc.dart';


class GoogleLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return FlatButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      color: Colors.white12,
      child: Text('Sign in with Google', style: TextStyle(color: Colors.white)),
      onPressed: () {
        BlocProvider.of<SGSignInBloc>(context).dispatch(
          LoginWithGooglePressed(),
        );

      },
    );


  }
}
