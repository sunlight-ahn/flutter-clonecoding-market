import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bamtol_market_study/src/splash/controller/splash_controller.dart';
import 'package:bamtol_market_study/src/common/controller/data_load_controller.dart';
import 'package:bamtol_market_study/src/common/controller/authentication_controller.dart';
import 'package:bamtol_market_study/src/common/components/getx_listener.dart';
import 'package:bamtol_market_study/src/splash/enum/step_type.dart';

// class SplashPage extends StatelessWidget {
//   const SplashPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(
//         child: Text(
//           'splash 페이지',
//           style: TextStyle(color: Colors.white),
//         ),
//       ),
//     );
//   }
// }

class _SplashPage extends GetView<SplashController> {
  const _SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GetxListener<bool>(
          listen: (bool isLogined) {
            if (isLogined) {
              Get.offNamed('/home');
            } else {
              Get.offNamed('/login');
            }
          },
          stream: Get.find<DataLoadController>()
              .isDataLoad, //Get.find<AuthenticationController>().isLogined,
          child: GetxListener<bool>(
            listen: (bool value) {
              if (value) {
                controller.loadStep(StepType.authCheck);
              }
            },
            stream: Get.find<DataLoadController>().isDataLoad,
            child: GetxListener<StepType>(
              initCall: () {
                controller.loadStep(StepType.dataLoad);
              },
              listen: (StepType? value) {
                if (value == null) return;
                switch (value) {
                  case StepType.init:
                  case StepType.dataLoad:
                    print('dataLoad..');
                    Get.find<DataLoadController>().loadData();
                    break;
                  case StepType.authCheck:
                    print('authCheck...');
                    Get.find<AuthenticationController>().authCheck();
                    break;
                }
              },
              stream: controller.loadStep,
              child: Obx(
                () {
                  return Text(
                    '${controller.loadStep.value.name}중 입니다.',
                    style: const TextStyle(color: Colors.white),
                  );
                },
              ),
            ),
          ),
        ),
      ),

      // body: Center(
      //   child: Obx(
      //     () => Text(
      //       '${controller.loadStep.value.name}중 입니다....',
      //       style: const TextStyle(color: Colors.white),
      //     ),
      //   ),
      // ),
      // body: Center(
      //   child: GetxListener<StepType>(
      //     initCall: () {
      //       controller.loadStep(StepType.dataLoad);
      //     },
      //     listen: (StepType? value) {
      //       if (value == null) return;
      //       switch (value) {
      //         case StepType.init:
      //         case StepType.dataLoad:
      //           Get.find<DataLoadController>().loadData();
      //           print('dataLoad..');
      //           break;
      //         case StepType.authCheck:
      //           print('authCheck...');
      //           break;
      //       }
      //     },
      //     stream: controller.loadStep,
      //     child: Obx(
      //       () {
      //         return Text(
      //           '${controller.loadStep.value.name}중 입니다.',
      //           style: const TextStyle(color: Colors.white),
      //         );
      //       },
      //     ),
      //   ),
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.loadStep(StepType.authCheck);
        },
      ),
    );
  }
}
