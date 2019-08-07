import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SGSignUpEvent extends Equatable {
  SGSignUpEvent([List props = const []]) : super(props);
}

///The events defined are:
///

//<editor-fold desc="EmailChanged - notifies the bloc that the user has changed the email">

class EmailChanged extends SGSignUpEvent {
  final String email;

  EmailChanged({@required this.email}) : super([email]);

  @override
  String toString() => 'EmailChanged { email :$email }';
}

//</editor-fold>

//<editor-fold desc="PasswordChanged - notifies the bloc that the user has changed the password">

class PasswordChanged extends SGSignUpEvent {
  final String password;

  PasswordChanged({@required this.password}) : super([password]);

  @override
  String toString() => 'PasswordChanged { password: $password }';
}

//</editor-fold>

//<editor-fold desc="Submitted - notifies the bloc that the user has submitted the form">

class Submitted extends SGSignUpEvent {
  final String email;
  final String password;
  final String fullName;

  Submitted({@required this.email, @required this.password, @required this.fullName,})
      : super([email, password]);

  @override
  String toString() {
    return 'Submitted { email: $email, password: $password , fullname:$fullName }';
  }
}
//</editor-fold>
