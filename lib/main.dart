import 'package:content_example/Services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:content_example/Services/route_generator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Here we set the URL strategy for our web app.
  // It is safe to call this function when running on mobile or desktop as well.
  setPathUrlStrategy();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  /// Adds banner to the child widget.
  Widget _wrapWithBanner(Widget child) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Banner(
          child: child,
          location: BannerLocation.topStart,
          message: 'BETA',
          color: Colors.limeAccent.withOpacity(0.6),
          textStyle: const TextStyle(
              fontWeight: FontWeight.w700, fontSize: 14.0, letterSpacing: 1.0),
          textDirection: TextDirection.rtl,
        ));
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StorageService(),
      child: ScreenUtilInit(
        designSize: const Size(1200, 900),
        minTextAdapt: true,
        builder: () => MaterialApp(
          title: 'USCA',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            visualDensity: VisualDensity.adaptivePlatformDensity,
            // Define the default brightness and colors.
            //brightness: Brightness.dark,
            primaryColor: Colors.lightBlue[800],

            // Define the default font family.
            fontFamily: 'Open Sans',

            // // Define the default `TextTheme`. Use this to specify the default
            // // text styling for headlines, titles, bodies of text, and more.
            textTheme: TextTheme(
              headline1:
                  TextStyle(fontSize: 72.sp, fontWeight: FontWeight.bold),
              headline6:
                  TextStyle(fontSize: 36.sp, fontStyle: FontStyle.italic),
              bodyText1: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'Hind',
                  fontWeight: FontWeight.bold),
              bodyText2: const TextStyle(fontSize: 14, fontFamily: 'Hind'),
            ),
            // add tabBarTheme
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.blue[800],
            ),

            tabBarTheme: TabBarTheme(
                unselectedLabelColor: const Color(0xFF0D47A1).withOpacity(0.5),
                unselectedLabelStyle: TextStyle(
                    fontSize: 14.0,
                    fontFamily: 'Hind',
                    color: const Color(0xFF0D47A1).withOpacity(0.5)),
                labelColor: const Color(0xFF0D47A1),
                labelStyle: const TextStyle(
                    fontSize: 16.0,
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0D47A1)), // color for text
                indicator: const UnderlineTabIndicator(
                    // color for indicator (underline)
                    borderSide:
                        BorderSide(width: 2, color: Color(0xFF0D47A1)))),

            listTileTheme: ListTileThemeData(
              dense: true,
              selectedTileColor: const Color(0xFFFFCA28),
              tileColor: const Color(0xFFFFCA28).withOpacity(0.5),
              textColor: Colors.black,
              style: ListTileStyle.drawer,
            ),

            bottomAppBarColor: Colors.blue[100],
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              backgroundColor: Colors.blue[100],
            ),
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              splashColor: Colors.blue[50],
              hoverColor: Colors.blue[400],
              backgroundColor: Colors.blue[800],
            ),
            splashColor: Colors.blue[50],
            //highlightColor: Colors.white.withOpacity(.3),
            primarySwatch: Colors.blue,
          ),
          initialRoute: '/',
          onGenerateRoute: RouteGenerator.generateRoute,
        ),
      ),
    );
  }
}
