import 'package:flutter/material.dart';
import 'package:sleep_giant/helper/user_repository.dart';
import 'package:sleep_giant/screens/sign_up/sign_up.dart';

class CreateAccountButton extends StatelessWidget {
  final UserRepository _userRepository;

  CreateAccountButton({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      color: Colors.white12,
      child: Text('SIGN UP', style: TextStyle(color: Colors.white)),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) {
            return SGSignUpScreen(userRepository: _userRepository);
          }),
        );
      },
    );
  }
}
