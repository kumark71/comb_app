import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hemoqr/controllers/auth_controller.dart';
import 'package:hemoqr/controllers/login_controller.dart';

import 'package:hemoqr/ui/utils/assets_constants.dart';
import 'package:hemoqr/ui/utils/constants.dart';
import 'package:upgrader/upgrader.dart';

import '../../utils/color_constants.dart';
import '../../widgets/button.dart';

class LoginPersonal extends StatelessWidget {
  const LoginPersonal({super.key});

  @override
  Widget build(BuildContext context) {
    LoginController loginController = Get.find();
    AuthController authController = Get.find();
    Size size = MediaQuery.of(context).size;
    var fontSize = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      body: UpgradeAlert(
        upgrader: Upgrader(
          durationUntilAlertAgain: const Duration(milliseconds: 1),
          dialogStyle: Platform.isIOS
              ? UpgradeDialogStyle.cupertino
              : UpgradeDialogStyle.material,
          canDismissDialog: false,
          showIgnore: false,
          showLater: false,
          shouldPopScope: () => false,
        ),
        child: Obx(
          () => loginController.isLoading.value != true
              ? SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Spacer(
                        flex: 2,
                      ),
                      Container(
                        width: size.width * .8,
                        child:
                        Image(
                          image: AssetImage(AssetUrlConstants.logoUrl),
                        ),
                      ),
                      Spacer(),
                      SizedBox(
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                loginController.editNum();
                              },
                              child: loginController.isSentOtp == 1
                                  ? Container(
                                      padding: EdgeInsets.all(8),
                                      width: size.width * .8,
                                      child: Text(
                                        "Edit Mobile Number",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge!
                                            .copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onPrimary,
                                            ),
                                      ))
                                  : Container(),
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 2,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                                borderRadius: BorderRadius.circular(15),
                                color: ColorConstant.cardBgColor,
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 2.0, horizontal: 10),
                                    child: TextFormField(
                                      cursorColor:
                                          Theme.of(context).colorScheme.primary,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(10)
                                      ],
                                      onChanged: loginController.mobileChanged,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimary,
                                          ),
                                      decoration: InputDecoration(
                                        // errorText:
                                        //     loginController.mobileError.value == ""
                                        //         ? null
                                        //         : loginController.mobileError.value,
                                        border: InputBorder.none,
                                        labelText: 'Mobile Number',

                                        labelStyle: Theme.of(context)
                                            .textTheme
                                            .labelMedium!
                                            .copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                            ),
                                        prefixIcon: Icon(
                                          Icons.mobile_screen_share_sharp,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                      ),
                                      keyboardType: TextInputType.phone,
                                      enabled:
                                          loginController.isSentOtp.value == 1
                                              ? false
                                              : true,
                                    ),
                                  ),
                                  loginController.isSentOtp.value == 1
                                      ? Column(
                                          children: [
                                            Divider(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onPrimary,
                                              thickness: 1,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 2.0,
                                                      horizontal: 10),
                                              child: TextFormField(
                                                cursorColor: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium!
                                                    .copyWith(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .onPrimary,
                                                    ),
                                                onChanged:
                                                    loginController.otpChanged,
                                                keyboardType:
                                                    TextInputType.number,
                                                inputFormatters: [
                                                  LengthLimitingTextInputFormatter(
                                                      4)
                                                ],
                                                decoration: InputDecoration(
                                                  prefixIcon: Icon(
                                                    Icons.password,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                  ),
                                                  iconColor: Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                  border: InputBorder.none,
                                                  labelText: 'OTP',

                                                  labelStyle: Theme.of(context)
                                                      .textTheme
                                                      .labelMedium!
                                                      .copyWith(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .primary,
                                                      ),

                                                  // errorText: loginController
                                                  //             .otpError.value ==
                                                  //         ""
                                                  //     ? null
                                                  //     : loginController
                                                  //         .otpError.value,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      : SizedBox(),
                                ],
                              ),
                            ),
                            Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15.0),
                                child: Column(
                                  children: [
                                    loginController.buttonLoading.value == false
                                        ? CustomButton(
                                            height: size.height * .06,
                                            buttonText:
                                                loginController.isSentOtp == 1
                                                    ? 'Verify OTP'
                                                    : 'Send OTP',
                                            onPressed: () {
                                              print("login");
                                              try {
                                                loginController
                                                            .isSentOtp.value !=
                                                        1
                                                    ? loginController.sendOtp()
                                                    : loginController
                                                        .verifyOTP();
                                              } catch (e) {
                                                log(e.toString());
                                              }
                                            },
                                            width: size.width,
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 30),
                                          )
                                        : CircleAvatar(
                                            backgroundColor: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            radius: 30,
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                            )),
                                    loginController.isSentOtp == 1
                                        ? GestureDetector(
                                            onTap: () {
                                              loginController.sendOtp();
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "Resend OTP",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelLarge!
                                                    .copyWith(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .onPrimary,
                                                    ),
                                              ),
                                            ),
                                          )
                                        : Container(),
                                  ],
                                )),
                            // loginController.isSentOtp != 1
                            //     ? Padding(
                            //         padding: EdgeInsets.symmetric(vertical: 15),
                            //         child: Container(
                            //           margin: EdgeInsets.zero,
                            //           height: size.height * .06,
                            //           width: size.width * .85,
                            //           decoration: BoxDecoration(
                            //             borderRadius: BorderRadius.circular(10),
                            //             color: Colors.green,
                            //           ),
                            //           child: Padding(
                            //             padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            //             child: Row(
                            //               mainAxisAlignment: MainAxisAlignment.center,
                            //               children: [
                            //                 Image.asset(
                            //                   "assets/banner/wapp.png",
                            //                   fit: BoxFit.fill,
                            //                 ),
                            //                 Text(
                            //                   "Login with WhatsApp",
                            //                   style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            //                         fontWeight: FontWeight.bold,
                            //                         color: Colors.white,
                            //                       ),
                            //                 )
                            //               ],
                            //             ),
                            //           ),
                            //         ),
                            //       )
                            //     : Container(),
                          ],
                        ),
                      ),
                      Spacer(
                        flex: 2,
                      ),
                      GestureDetector(
                        onTap: () {
                          authController.isProfessional = true;
                          Get.offAllNamed("/loginProfessional");
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Are you a",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: fontSize * 18,
                                        color: Color.fromARGB(124, 0, 0, 0),
                                      ),
                                ),
                                TextSpan(
                                  text: " professional ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
                                        fontSize: fontSize * 18,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                TextSpan(
                                  text: "user?",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: fontSize * 18,
                                        color: Color.fromARGB(124, 0, 0, 0),
                                      ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Constants.CustomLoader(),
        ),
      ),
    );
  }
}
