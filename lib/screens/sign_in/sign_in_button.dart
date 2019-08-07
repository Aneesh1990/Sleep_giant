import 'package:flutter/material.dart';

class SGSignInButton extends StatelessWidget {
  final VoidCallback _onPressed;

  SGSignInButton({Key key, VoidCallback onPressed})
      : _onPressed = onPressed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
      return FlatButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      color: Colors.white12,
      child: Text('SIGN IN', style: TextStyle(color: Colors.white)),
      onPressed: _onPressed,
    );
  }
}
