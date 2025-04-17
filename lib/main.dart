import 'package:bamtol_market_study/src/common/controller/bottom_nav_controller.dart';
import 'package:bamtol_market_study/src/common/repository/cloud_firebase_storage_repository.dart';
import 'package:bamtol_market_study/src/home/page/home_page.dart';
import 'package:bamtol_market_study/src/home/controller/home_controller.dart';
import 'package:bamtol_market_study/src/product/detail/controller/product_detail_controller.dart';
import 'package:bamtol_market_study/src/root.dart';
import 'package:bamtol_market_study/src/common/controller/common_layout_controller.dart';
import 'package:bamtol_market_study/src/common/controller/data_load_controller.dart';
import 'package:bamtol_market_study/src/splash/controller/splash_controller.dart';
import 'package:bamtol_market_study/src/common/controller/authentication_controller.dart';
import 'package:bamtol_market_study/src/user/login/page/login_page.dart';
import 'package:bamtol_market_study/src/app.dart';
import 'package:bamtol_market_study/src/user/repository/authentication_repository.dart';
import 'package:bamtol_market_study/src/user/login/controller/login_controller.dart';
import 'package:bamtol_market_study/firebase_options.dart';
import 'package:bamtol_market_study/src/user/repository/user_repository.dart';
import 'package:bamtol_market_study/src/product/repository/product_repository.dart';
import 'package:bamtol_market_study/src/product/write/controller/product_write_controller.dart';
import 'package:bamtol_market_study/src/user/signup/page/signup_page.dart';
import 'package:bamtol_market_study/src/product/write/page/product_write_page.dart';
import 'package:bamtol_market_study/src/product/detail/page/product_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:bamtol_market_study/src/user/signup/controller/signup_controller.dart';

late SharedPreferences prefs;

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Firebase SDK가 안드로이드와 ios의 네이티브 코드와 상호작용하기 위해서 설정.
  prefs = await SharedPreferences.getInstance();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ); // firebase 앱 시작

  runApp(const MyApp());
}

int count = 0;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   title: 'Flutter Demo',
    //   home: Scaffold(
    //     body: Center(
    //       child: Image.asset('assets/images/logo_simbol.png'),
    //     ),
    //   ),
    // );
    var db = FirebaseFirestore.instance;

    return GetMaterialApp(
      title: '클론코딩',
      initialRoute: '/',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          elevation: 0,
          color: Color(0xff212123),
          titleTextStyle: TextStyle(
            color: Colors.white,
          ),
        ),
        scaffoldBackgroundColor: const Color(0xff212123),
      ),
      initialBinding: BindingsBuilder(() {
        var authenticationRepository =
            AuthenticationRepository(FirebaseAuth.instance);
        var user_repository = UserRepository(db);
        Get.put(authenticationRepository);
        Get.put(user_repository);
        Get.put(CommonLayoutController());
        Get.put(ProductRepository(db));
        Get.put(BottomNavController());
        Get.put(SplashController());
        Get.put(DataLoadController());
        Get.put(AuthenticationController(
          authenticationRepository,
          user_repository,
        ));
        Get.put(CloudFirebaseRepository(FirebaseStorage.instance));
      }),
      getPages: [
        GetPage(name: '/', page: () => const App()),
        GetPage(
          name: '/home',
          page: () => const Root(),
          binding: BindingsBuilder(() {
            Get.put(HomeController(Get.find<ProductRepository>()));
          }),
        ), //root로 수정 const HomePage()),
        //GetPage(name: '/login', page: () => const LoginPage()),
        GetPage(
            name: '/login',
            page: () => const LoginPage(),
            binding: BindingsBuilder(() {
              Get.lazyPut<LoginController>(
                  () => LoginController(Get.find<AuthenticationRepository>()));
            })),
        //GetPage(name: '/signup', page: () => const SignupPage()),
        GetPage(
          name: '/signup/:uid',
          page: () => const SignupPage(),
          binding: BindingsBuilder(
            () {
              Get.create<SignupController>(
                () => SignupController(Get.find<UserRepository>(),
                    Get.parameters['uid'] as String),
              );
            },
          ),
        ),
        //GetPage(name: '/product/write', page: () => const ProductWritePage()),
        // GetPage(
        //   name: '/product/write',
        //   page: () => const ProductWritePage(),
        //   binding: BindingsBuilder(
        //     () {
        //       Get.put(
        //         ProductWriteController(
        //           Get.find<AuthenticationController>().userModel.value,
        //           Get.find<ProductRepository>(),
        //         ),
        //       );
        //     },
        //   ),
        // ),
        GetPage(
          name: '/product/write',
          page: () => ProductWritePage(),
          binding: BindingsBuilder(
            () {
              Get.put(ProductWriteController(
                Get.find<AuthenticationController>().userModel.value,
                Get.find<ProductRepository>(),
                Get.find<CloudFirebaseRepository>(),
              ));
            },
          ),
        ),
        GetPage(
          name: '/product/detail/:docId',
          page: () => const ProductDetailView(),
          binding: BindingsBuilder(
            () {
              Get.put(ProductDetailController(
                Get.find<ProductRepository>(),
                Get.find<AuthenticationController>().userModel.value,
              ));
            },
          ),
        ),
      ],
    );
  }
}
