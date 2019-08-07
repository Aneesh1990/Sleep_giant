import 'package:bloc/bloc.dart';

class SGBlocDelegate extends BlocDelegate {

  //<editor-fold desc="override onTransition, onError and bloc state changes (transitions)">
  ///which allows us to override onTransition and onError and will help us see all bloc state changes (transitions) and errors in one place!
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(error);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  //</editor-fold>

}
