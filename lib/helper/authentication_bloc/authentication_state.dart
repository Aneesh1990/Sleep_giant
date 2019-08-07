import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AuthenticationState extends Equatable {
  AuthenticationState([List props = const []]) : super(props);
}

 //<editor-fold desc="AuthenticationState - Uninitialized">

class Uninitialized extends AuthenticationState {
  @override
  String toString() => 'Uninitialized';
}
//</editor-fold>

 //<editor-fold desc="AuthenticationState - Authenticated">
class Authenticated extends AuthenticationState {
  final String displayName;

  Authenticated(this.displayName) : super([displayName]);

  @override
  String toString() => 'Authenticated { displayName: $displayName }';
}
//</editor-fold>

 //<editor-fold desc="AuthenticationState - Unauthenticated">
class Unauthenticated extends AuthenticationState {
  @override
  String toString() => 'Unauthenticated';
}
//</editor-fold>
