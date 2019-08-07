import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sleep_giant/helper/authentication_bloc/bloc.dart';

class HomeScreen extends StatelessWidget {
  final String name;

  HomeScreen({Key key, @required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

    decoration:new BoxDecoration(
    image: new DecorationImage(
    image: new AssetImage("assets/theme_bg.png"),
    fit: BoxFit.cover,
    ),),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[

        IconButton(
        icon: Icon(Icons.exit_to_app,color: Colors.white,),
        onPressed: () {
          BlocProvider.of<AuthenticationBloc>(context).dispatch(
            LoggedOut(),
          );
        },
      ),

            Center(child: Text('Welcome $name!')),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(color: Colors.blue,
                  child: Icon(Icons.multiline_chart),),
                Container(child: Text('Wind Down'),)
              ],

            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(color: Colors.blue,
                  child: Icon(Icons.multiline_chart),),
                Container(child: Text('Sleep Deck'),)
              ],

            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(color: Colors.blue,
                  child: Icon(Icons.multiline_chart),),
                Container(child: Text('Nap Recovery'),)
              ],

            ),
          ],
        ),
      ),
    );
  }
}


