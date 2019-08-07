import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AuthenticationEvent extends Equatable {
  AuthenticationEvent([List props = const []]) : super(props);
}
 //<editor-fold desc="AuthenticationEvent - AppStarted">

class AppStarted extends AuthenticationEvent {
  @override
  String toString() => 'AppStarted';
}
//</editor-fold>

 //<editor-fold desc="AuthenticationEvent - LoggedIn">

class LoggedIn extends AuthenticationEvent {
  @override
  String toString() => 'LoggedIn';
}
//</editor-fold>

 //<editor-fold desc="AuthenticationEvent - LoggedOut">

class LoggedOut extends AuthenticationEvent {
  @override
  String toString() => 'LoggedOut';
}
//</editor-fold>