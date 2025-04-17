import 'package:get/get.dart';
import 'package:bamtol_market_study/src/splash/enum/step_type.dart';

class SplashController extends GetxController {
  //Rx<StepType> loadStep = StepType.init.obs;
  Rx<StepType> loadStep = StepType.dataLoad.obs;
  
  void changeStep(StepType type) {
    loadStep(type);
  }
}
