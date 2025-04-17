import 'package:get/get.dart';
import 'package:bamtol_market_study/src/user/model/user_model.dart';
import 'package:bamtol_market_study/src/user/repository/authentication_repository.dart';
import 'package:bamtol_market_study/src/user/repository/user_repository.dart';
import 'package:bamtol_market_study/src/common/enum/authentication_status.dart';

class AuthenticationController extends GetxController {
  AuthenticationController(
      this._authenticationRepository, this._userRepository);
  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;

  //RxBool isLogined = false.obs;
  Rx<AuthenticationStatus> status = AuthenticationStatus.init.obs;
  Rx<UserModel> userModel = const UserModel().obs;

  void authCheck() async {
    //await Future.delayed(const Duration(milliseconds: 3000));
    //isLogined(true);
    _authenticationRepository.user.listen((user) {
      _userStateChangedEvent(user);
    });
  }

  void _userStateChangedEvent(UserModel? user) async {
    if (user == null) {
      status(AuthenticationStatus.unknown);
    } else {
      print("########## auth OK");
      var result = await _userRepository.findUserOne(user.uid!);
       if (result == null) {
         userModel(user);
         status(AuthenticationStatus.unAuthenticated);
       } else {
        status(AuthenticationStatus.authentication);
         userModel(result);
       }
    }
  }

  void logout() async {
    //isLogined(false);
    await _authenticationRepository.logout();
  }
}

// class AuthenticationController extends GetxController {
//   RxBool isLogined = false.obs;

//   void authCheck() async {
//     await Future.delayed(const Duration(milliseconds: 3000));
//     isLogined(true);
//   }

//   void logout() {
//     isLogined(false);
//   }
// }
