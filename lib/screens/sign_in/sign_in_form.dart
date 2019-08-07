import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sleep_giant/helper/authentication_bloc/authentication_bloc.dart';
import 'package:sleep_giant/helper/authentication_bloc/authentication_event.dart';
import 'package:sleep_giant/helper/user_repository.dart';
import 'package:sleep_giant/screens/sign_in/bloc/sign_in_event.dart';
import 'package:sleep_giant/screens/sign_in/create_account_button.dart';
import 'package:sleep_giant/screens/sign_in/google_login_button.dart';
import 'package:sleep_giant/screens/sign_in/sign_in_button.dart';

import 'bloc/sign_in_bloc.dart';
import 'bloc/sign_in_state.dart';


/**
 * Here use a BlocBuilder widget in order to rebuild the UI in response to 
 * different [SGSignInState].Whenever the email or password changes, we dispatch 
 * an event to the [SGSignInBloc] in order for it to validate the current form state
 * and return the new form state
 */
///

class SGSignInForm extends StatefulWidget {
  final UserRepository _userRepository;

  SGSignInForm({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  State<SGSignInForm> createState() => _SGSignInFormState();
}

class _SGSignInFormState extends State<SGSignInForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  SGSignInBloc _signInBloc;

  UserRepository get _userRepository => widget._userRepository;

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isLoginButtonEnabled(SGSignInState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _signInBloc = BlocProvider.of<SGSignInBloc>(context);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SGSignInBloc, SGSignInState>(
      listener: (context, state) {
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('Login Failure'), Icon(Icons.error)],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }
        if (state.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Sign In...'),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }
        if (state.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context).dispatch(LoggedIn());
        }
      },
      child: BlocBuilder<SGSignInBloc, SGSignInState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(0.0),
            child: Form(
              child: ListView(
                children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Image.asset("assets/tutorial_logo.png"),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                  Card(
                      color: Colors.white12,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 10,
                            ),
                            Text('SIGN IN',style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold,color: Colors.white),),

                            TextFormField(
                              style: TextStyle(color: Colors.white),
                              controller: _emailController,
                              decoration: InputDecoration(
                                  labelText: 'Email Address',
                                  labelStyle: TextStyle(color: Colors.white),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white54),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white54),
                                ),
                                border:
                                UnderlineInputBorder(borderSide: BorderSide(color: Colors.white54)),
                              ),
                              autovalidate: true,
                              autocorrect: false,
                              validator: (_) {
                                return !state.isEmailValid
                                    ? 'Invalid Email'
                                    : null;
                              },
                            ),
                            TextFormField(
                              style: TextStyle(color: Colors.white),
                              controller: _passwordController,
                              decoration: InputDecoration(
                                  labelText: 'Password',
                                  labelStyle: TextStyle(color: Colors.white),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white54),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white54),
                                ),
                                border:
                                UnderlineInputBorder(borderSide: BorderSide(color: Colors.white54)),),
                              obscureText: true,
                              autovalidate: true,
                              autocorrect: false,
                              validator: (_) {
                                return !state.isPasswordValid
                                    ? 'Invalid Password'
                                    : null;
                              },
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  SGSignInButton(
                                    onPressed: _onFormSubmitted,
                                  ),
                                  GoogleLoginButton(),
                                  Text("Don't have an account?",textAlign: TextAlign.center,style: TextStyle(color: Colors.white54),),
                                  CreateAccountButton(
                                      userRepository: _userRepository),
                                  Text("© Ignite Yourself LLC 2012-2019 All Rights Reserved",textAlign: TextAlign.center,style: TextStyle(color: Colors.white54),),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  
  
 //<editor-fold desc="Methods :- Email changed, password changed and Form Submitted">
  void _onEmailChanged() {
    _signInBloc.dispatch(
      EmailChanged(email: _emailController.text),
    );
  }

  void _onPasswordChanged() {
    _signInBloc.dispatch(
      PasswordChanged(password: _passwordController.text),
    );
  }

  void _onFormSubmitted() {
    _signInBloc.dispatch(
      LoginWithCredentialsPressed(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }
  
  //</editor-fold>

}
