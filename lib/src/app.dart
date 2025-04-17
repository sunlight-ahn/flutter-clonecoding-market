import 'package:flutter/material.dart';
import 'package:bamtol_market_study/main.dart';
import 'package:bamtol_market_study/src/init/page/init_start_page.dart';
import 'package:bamtol_market_study/src/splash/page/splash_page.dart';

// class App extends StatelessWidget {
//   const App({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Image.asset('assets/images/logo_simbol.png'),
//       ),
//     );
//   }
// }

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late bool isInitStarted; //1

  @override
  void initState() {
    super.initState();
    isInitStarted = prefs.getBool('isInitStarted') ?? true;
  }

  @override
  Widget build(BuildContext context) {
    //   return Scaffold(
    //     body: Center(
    //       child: Image.asset('assets/images/logo_simbol.png'),
    //     ),
    //   );
    // }
    // prefs.setBool('isInitStarted', true);
    // if (isInitStarted) {
    //   prefs.setBool('isInitStarted', false);
    //   print("true");
    //   print(isInitStarted);
    //   return const InitStartPage();
    // } else {
    //   print("false");
    //   print(isInitStarted);
    //   return const SplashPage();
    // }
    //return isInitStarted ? const InitStartPage() : const SplashPage();
    return isInitStarted
        ? InitStartPage(
            onStart: () {
              setState(() {
                isInitStarted = false;
              });
              prefs.setBool('isInitStarted', isInitStarted);
            },
          )
        : const SplashPage();
  }
}
