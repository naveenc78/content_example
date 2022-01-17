import 'package:flutter/material.dart';
import 'package:content_example/Screens/homepage_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    String tab = '';
    //psese the positional parameters in settings.name
    int nPos = 0, nlength = 0;
    String first = '/';
    String rest = '';
    if (settings.name != null) {
      if ((nlength = settings.name!.length) > 1) {
        nPos = settings.name!.indexOf('/', 1);
        first = (nPos < 0) ? settings.name! : settings.name!.substring(0, nPos);

        if (nPos > 0) {
          if (nPos < nlength - 1) {
            rest = settings.name!.substring(nPos + 1, nlength);
          }
        }
      }
    }

    switch (first) {
      case '/blogs':
        tab = 'Blogs';
        break;
      case '/champions':
        tab = 'Champions';
        break;
      case '/pavilion':
        tab = '';
        break;
      case '/sponsors':
        tab = 'Sponsors';
        break;
      case '/buzz':
        tab = 'Buzz';
        break;
      case '/':
        tab = '';
        break;

      default:
        // If there is no such named route in the switch statement, e.g. /third
        tab = '';
        break;
    }

    // Validation of correct data type
    return MaterialPageRoute(
      builder: (_) => MyHomePage(
        title: 'United States Carrom Association',
        tab: tab,
        pparam: rest,
        data: args,
      ),
    );
  }

  // static Route<dynamic> _errorRoute() {
  //   return MaterialPageRoute(builder: (_) {
  //     return Scaffold(
  //       appBar: AppBar(
  //         title: const Text('Error'),
  //       ),
  //       body: const Center(
  //         child: Text('ERROR'),
  //       ),
  //     );
  //   });
  // }
}
