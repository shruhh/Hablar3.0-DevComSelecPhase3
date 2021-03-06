import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hablar/helpers/app_constants.dart';
import 'package:hablar/models/user_data.dart';
import 'package:hablar/screens/attendees_screen.dart';
import 'package:hablar/screens/chat_screen.dart';
import 'package:hablar/screens/login_screen.dart';
import 'package:hablar/services/auth_service.dart';
import 'package:hablar/services/database_service.dart';
import 'package:hablar/services/storage_service.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_) => UserData(),
    ),
    Provider<AuthService>(
      create: (_) => AuthService(),
    ),
    Provider<DataBaseService>(
      create: (_) => DataBaseService(),
    ),
    Provider<StorageService>(
      create: (_) => StorageService(),
    ),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  Widget _getScreenId() {
    return StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          Provider.of<UserData>(context).currentUserId = snapshot.data.uid;
          return AttendeesScreen();
        } else {
          return LoginScreen();
        }
      },
    );
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "HABLAR 3.0",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppConstants.hexToColor(AppConstants.APP_PRIMARY_COLOR),
        backgroundColor:
        AppConstants.hexToColor(AppConstants.APP_BACKGROUND_COLOR),
        primaryColorLight:
        AppConstants.hexToColor(AppConstants.APP_PRIMARY_COLOR_LIGHT),
        accentColor: Colors.black,
        accentIconTheme: IconThemeData(color: Colors.black),
        dividerColor: Colors.black12,
        textTheme: TextTheme(
          caption: TextStyle(color: Colors.white),
        ),
      ),
      home: _getScreenId(),
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        AttendeesScreen.id: (context) => AttendeesScreen(),
      },
    );
  }
}

_appDrawer() {
  return Drawer(
    child: Column(
      children: <Widget>[
        DrawerHeader(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              CircleAvatar(
                radius: 30.0,
                backgroundImage:
                AssetImage('assets/images/user_placeholder.jpg'),
                backgroundColor: Colors.transparent,
              ),
              Text(
                'Shruti Singh',
                style: TextStyle(color: Colors.black),
              ),
              Text(
                'Developer @ DevCom',
                style: TextStyle(color: Colors.black),
              )
            ],
          ),
        ),
        Spacer(),
        ListTile(
          leading: Icon(Icons.home),
          title: Text('Home'),
          onTap: () {},
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.people),
          title: Text('Attendants'),
          onTap: () {},
        ),
        Spacer(flex: 8),
      ],
    ),
  );
}