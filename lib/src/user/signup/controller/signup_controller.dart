import 'package:bamtol_market_study/src/user/model/user_model.dart';
import 'package:bamtol_market_study/src/user/repository/user_repository.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  final UserRepository _userRepository;
  final String uid;
  SignupController(
    this._userRepository,
    this.uid,
  );

  RxString userNickName = ''.obs;
  RxBool isPossibleUseNickName = false.obs;

  @override
  void onInit() {
    super.onInit();
    print('onInit(), $uid');
    debounce(userNickName, checkDuplicationNickName,
        time: const Duration(milliseconds: 500));
  }

  checkDuplicationNickName(String value) async {
    print('checkDuplicationNickName(), $value');
    //await _userRepository.checkDuplicationNickName(value);
    var isPossibleUse = await _userRepository.checkDuplicationNickName(value);
    print('checkDuplicationNickName() isPossible, $isPossibleUse');
    isPossibleUseNickName(isPossibleUse);
  }

  changeNickName(String nickName) {
    userNickName(nickName);
  }

  //  signup() async {
  //   var newUser = UserModel.create(userNickName.value, uid, "email");
  //   var result = await _userRepository.signup(newUser);
  //   return result;
  // }
  Future<String?> signup() async {
    var newUser = UserModel.create(userNickName.value, uid, "email");
    var result = await _userRepository.signup(newUser);
    return result;
  }
}
