import 'package:flutter/material.dart';


import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';

import 'provider/post_provider.dart';
import 'screens/category_screens.dart';
import 'screens/home_screens.dart';
import 'screens/login_screens.dart';
import 'screens/post_details_screens.dart';
import 'screens/register_screens.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LocalStorage storage = LocalStorage("usertoken");
    return ChangeNotifierProvider(
      create: (ctx) => PostState(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
          accentColor: Colors.orange,
        ),
        home: FutureBuilder(
          future: storage.ready,
          builder: (context, snapshop) {
            if (snapshop.data == null) {
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
           /* if (storage.getItem('token') == null) {
              return LoginScreens();
            }*/
            return HomeScreens();
          },
        ),
        routes: {
          HomeScreens.routeName: (ctx) => HomeScreens(),
          PostDetailsScreens.routeName: (ctx) => PostDetailsScreens(),
          CategoryScreens.routeName: (ctx) => CategoryScreens(),
         // LoginScreens.routeName: (ctx) => LoginScreens(),
         // RegisterScreens.routeName: (ctx) => RegisterScreens(),
        },
      ),
    );
  }
}