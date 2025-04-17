import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:bamtol_market_study/src/common/components/app_font.dart';
import 'package:bamtol_market_study/src/common/components/btn.dart';

class InitStartPage extends StatelessWidget {
  final Function() onStart;
  const InitStartPage({super.key, required this.onStart});
  //const InitStartPage({super.key});

  @override
  Widget build(BuildContext context) {
    //   return const Scaffold(
    //     body: Center(
    //       child: Text(
    //         '초기소개 페이지',
    //         style: TextStyle(color: Colors.white),
    //       ),
    //     ),
    //   );
    // }
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 99,
              height: 116,
              child: Image.asset(
                'assets/images/logo_simbol.png',
              ),
            ),
            // const SizedBox(height: 40),
            // Text(
            //   '당신 근처의 밤톨마켓',
            //   style: GoogleFonts.notoSans(
            //     fontWeight: FontWeight.bold,
            //     fontSize: 20,
            //     color: Colors.white,
            //   ),
            // ),
            // const SizedBox(height: 15),
            // Text(
            //   '중고 거래부터 동네 정보까지, \n지금 내 동네를 선택하고 시작해보세요!',
            //   textAlign: TextAlign.center,
            //   style: GoogleFonts.notoSans(
            //     //fontWeight: FontWeight.bold,
            //     fontSize: 18,
            //     color: Colors.white,
            //   ),
            // ),
            const SizedBox(height: 40),
            const AppFont(
              '당신 근처의 개발자마켓',
              fontWeight: FontWeight.bold,
              size: 20,
            ),
            const SizedBox(height: 15),
            AppFont(
              '중고 거래부터 동네 정보까지, \n지금 내 동네를 선택하고 시작해보세요!',
              align: TextAlign.center,
              size: 18,
              color: Colors.white.withOpacity(0.6),
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
            left: 25, right: 25, bottom: 25 + Get.mediaQuery.padding.bottom),
        child: Btn(
          onTap: onStart, //() {},
          child: const AppFont(
            '시작하기',
            align: TextAlign.center,
            size: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        // child: ClipRRect(
        //   borderRadius: BorderRadius.circular(7),
        //   child: Container(
        //     padding: const EdgeInsets.symmetric(vertical: 15),
        //     //child: const Btn(),
        //     //color: const Color(0xffED7738),
        //     child: const AppFont(
        //       '시작하기',
        //       align: TextAlign.center,
        //       size: 18,
        //       fontWeight: FontWeight.bold,
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
