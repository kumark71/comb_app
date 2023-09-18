import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hemoqr/controllers/auth_controller.dart';

class AccountStatus extends StatelessWidget {
  const AccountStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AccountStatusController accountStatusController = Get.find();
    AuthController authController = Get.find();
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Account Status",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),

                Text(
                  "Your account is under processing",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.black,
                      ),
                ),

                Text(
                  "Contact Us:",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),

                Text(
                  "Phone: +919191919191",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[500],
                      ),
                ),
                Text(
                  "Email: support@smartqr.com",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[500],
                      ),
                ),
                // Add spacing for the button
                ElevatedButton(
                  onPressed: () {
                    authController.logout();
                  },
                  child: Text(
                    "Logout",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    authController.loadUser();
                  },
                  child: Text(
                    "Refresh",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AccountStatusController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }
}
