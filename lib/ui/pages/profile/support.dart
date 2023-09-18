import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hemoqr/controllers/support_controller.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    SupportContoller supportContoller = Get.find();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
      child: Obx(
        () => Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "support".tr,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                  Spacer(),
                ],
              ),
              Spacer(),
              Text(
                "Raise a ticket".tr,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: TextFormField(
                  onChanged: supportContoller.messageChanged,
                  maxLines: 10,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIconColor: Theme.of(context).colorScheme.primary,
                    labelText: "enter_message".tr,
                    hintStyle:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                    labelStyle:
                        Theme.of(context).textTheme.labelMedium!.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                    suffixIconColor: Theme.of(context).colorScheme.primary,
                    prefixIcon: Icon(Icons.message),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                    iconColor: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              Container(
                width: size.width,
                height: size.height * 0.07,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: supportContoller.loading == false
                    ? ElevatedButton(
                        onPressed: () {
                          if (supportContoller.loading == false) {
                            FocusScope.of(context).unfocus();

                            supportContoller.uploadTicket();
                          } else {}
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                        ),
                        child: supportContoller.loading == false
                            ? Text(
                                "submit".tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(
                                      color:
                                          Theme.of(context).colorScheme.surface,
                                    ),
                              )
                            : CircularProgressIndicator(
                                color: Colors.white,
                              ),
                      )
                    : Center(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                      ),
              ),
              Spacer(),
              Row(children: <Widget>[
                Expanded(
                  child: Divider(
                    endIndent: 10,
                    height: MediaQuery.of(context).size.height * 0.05,
                    thickness: 2,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                Text(
                  "Contact Us".tr,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
                Expanded(
                  child: Divider(
                    indent: 10,
                    height: MediaQuery.of(context).size.height * 0.05,
                    thickness: 2,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      width: size.width / 2.5,
                      height: size.height * 0.055,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      child: ElevatedButton.icon(
                        onPressed: () {
                          supportContoller.sendEmail();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                        ),
                        icon: Icon(
                          Icons.email_sharp,
                          color: Colors.white,
                        ), //icon data for elevated button
                        label: Text(
                          "email".tr,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).colorScheme.surface,
                              ),
                        ), //label text
                      )),
                  Container(
                      width: size.width / 2.5,
                      height: size.height * 0.055,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      child: ElevatedButton.icon(
                        onPressed: () {
                          supportContoller.makePhoneCall();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                        ),
                        icon: Icon(
                          Icons.phone_android_sharp,
                          color: Colors.white,
                        ), //icon data for elevated button
                        label: Text(
                          "phone".tr,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).colorScheme.surface,
                              ),
                        ), //label text
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
