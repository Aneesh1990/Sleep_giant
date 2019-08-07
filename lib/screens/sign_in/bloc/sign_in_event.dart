import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class SGSignInEvent extends Equatable {
  SGSignInEvent([List props = const []]) : super(props);
}

///The events defined are:

 //<editor-fold desc="EmailChanged - notifies the bloc that the user has changed the email">

class EmailChanged extends SGSignInEvent {
  final String email;

  EmailChanged({@required this.email}) : super([email]);

  @override
  String toString() => 'EmailChanged { email :$email }';
}
 //</editor-fold>

 //<editor-fold desc="PasswordChanged - notifies the bloc that the user has changed the password">

class PasswordChanged extends SGSignInEvent {
  final String password;

  PasswordChanged({@required this.password}) : super([password]);

  @override
  String toString() => 'PasswordChanged { password: $password }';
}

//</editor-fold>

 //<editor-fold desc="Submitted - notifies the bloc that the user has submitted the form">

class Submitted extends SGSignInEvent {
  final String email;
  final String password;

  Submitted({@required this.email, @required this.password})
      : super([email, password]);

  @override
  String toString() {
    return 'Submitted { email: $email, password: $password }';
  }
}
//</editor-fold>

 //<editor-fold desc="LoginWithGooglePressed - notifies the bloc that the user has pressed the Google Sign In button">

class LoginWithGooglePressed extends SGSignInEvent {
  @override
  String toString() => 'LoginWithGooglePressed';
}

//</editor-fold>

 //<editor-fold desc="LoginWithCredentialsPressed - notifies the bloc that the user has pressed the regular sign in button.">
class LoginWithCredentialsPressed extends SGSignInEvent {
  final String email;
  final String password;

  LoginWithCredentialsPressed({@required this.email, @required this.password})
      : super([email, password]);

  @override
  String toString() {
    return 'LoginWithCredentialsPressed { email: $email, password: $password }';
  }
}

//</editor-fold>
