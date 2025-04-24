import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:indar_deco/core/styles/colors.dart';
import 'package:indar_deco/presentation/controllers/authentication_controller.dart';
import 'package:indar_deco/presentation/controllers/cart_controller.dart';
import 'package:indar_deco/presentation/controllers/category_controller.dart';
import 'package:indar_deco/presentation/controllers/main_screen_controller.dart';
import 'package:indar_deco/presentation/controllers/notifications_controller.dart';
import 'package:indar_deco/presentation/controllers/product_controller.dart';
import 'package:indar_deco/presentation/controllers/promotion_controller.dart';
import 'package:indar_deco/presentation/controllers/settings_controller.dart';
import 'package:indar_deco/presentation/controllers/supplier_controller.dart';
import 'package:indar_deco/presentation/controllers/wishlist_controller.dart';
import 'package:indar_deco/presentation/ui/screens/authentication/sign_in_screen.dart';
import 'package:indar_deco/presentation/ui/screens/main/main_screen.dart';

import '../../../../di.dart';
import '../../../../domain/usecases/authentication_usecases/auto_login_usecase.dart';
import '../../../../domain/usecases/authentication_usecases/get_user_usecase.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static Future<void> init(BuildContext context, int duration) async {

    Get.put(SettingsController()) ;
    Get.put(AuthenticationController()) ;
    Get.put(CartController());
    Get.put(WishListController()) ;
    Get.put(MainScreenController());
    Get.put(SupplierController());
    Get.put(ProductController());
   Get.put(CategoryController()) ;
     Get.put(PromotionController());
    final  SettingsController settingsController = Get.find() ;
    final AuthenticationController authController = Get.find();
    //final WishListController wishListController = Get.find();
    final CartController cartController = Get.find();

    final lang = await settingsController.loadLocale();
    settingsController.setLocal(lang);
    bool res = true;
    final autologiVarReturn = await AutoLoginUsecase(sl()).call();
    autologiVarReturn.fold((l) {
       res = false;
    }, (r) async {
      authController.token = r;
      final user =
          await GetUserUsecase(sl()).call(r.userId);
      user.fold((l) {
         res = false;
      }, (r)async {
        authController.currentUser = r;
     //  await wishListController.getUserWishlist(authController.currentUser.id!);
        await cartController.getUserCart();
        Get.put(NotificationsController());
      });
   
    });
    Future.delayed( Duration(seconds: duration), () {


      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder:(_)=>res ?  const MainScreen():const LoginScreen()));
    });
  }
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      extendBodyBehindAppBar: true,
      body: FutureBuilder(
        future: SplashScreen.init(context, 2),
        builder:(_,snapshot)=> Center(
          
         child: Image.asset('assets/images/instar.jpg',width: 250.w,)
        ),
      ),
    );
  }
}
