import 'package:exhibition_book/core/utils/app_colors.dart';
import 'package:exhibition_book/core/utils/profile_helpers.dart';
import 'package:exhibition_book/features/profile/screens/favorites.dart';
import 'package:exhibition_book/features/profile/screens/help_center.dart';
import 'package:exhibition_book/features/profile/screens/my_account.dart';
import 'package:exhibition_book/features/profile/screens/offers.dart';
import 'package:exhibition_book/features/profile/screens/order_history.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Scaffold(
        backgroundColor: AppColors.background,
        appBar: makeAppBar(
          title: "Profile",
          titleColor: AppColors.textPrimary,
          enableLeading: false,
          barBackgroundColor: AppColors.background,
        ),
        body: Column(
          children: [
            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25.0,
                vertical: 10,
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage("assets/images/test-img.jpg"),
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "John Doe",
                        style: TextStyle(
                          color: AppColors.grey900,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "(+1) 234 567 890",
                        style: TextStyle(
                          color: AppColors.grey500,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),

                  // I wrapped it in a container to make the clickable area
                  //  big enough to touch it using our fingers.
                  GestureDetector(
                    child: Container(
                      width: 100,
                      height: 50,
                      child: Center(
                        child: Text(
                          "Logout",
                          style: TextStyle(
                            color: AppColors.red,
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      Get.bottomSheet(
                        Container(
                          height: 312,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColors.background,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 50,
                              horizontal: 20.0,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Logout",
                                  style: TextStyle(
                                    color: AppColors.grey900,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(height: 15),
                                Text(
                                  "Are you sure you want to logout?",
                                  style: TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: 15),

                                // Logout button
                                GestureDetector(
                                  child: _makeBottomSheetButton(
                                    label: "Logout",
                                    labelColor: AppColors.background,
                                    buttonColor: AppColors.primary,
                                  ),
                                  onTap: () {
                                    ///TODO: What shoud we do here?
                                  },
                                ),
                                SizedBox(height: 15),

                                // cancel button.
                                GestureDetector(
                                  child: _makeBottomSheetButton(
                                    label: "Cancel",
                                    buttonColor: AppColors.grey300,
                                    labelColor: AppColors.primary,
                                  ),
                                  onTap: () {
                                    Get.back();
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Divider(),
            InkWell(
              child: _makeNavigationRecord(
                label: "My Account",
                avatarName: "profile.svg",
              ),
              onTap: () {
                Get.to(MyAccount());
              },
            ),

            InkWell(
              child: _makeNavigationRecord(
                label: "Address",
                avatarName: "address.svg",
              ),
              onTap: () {
                // Get.to(Address());
              },
            ),

            InkWell(
              child: _makeNavigationRecord(
                label: "Offers & Promos",
                avatarName: "offer.svg",
              ),
              onTap: () {
                Get.to(Offers());
              },
            ),
            InkWell(
              child: _makeNavigationRecord(
                label: "Your Favorites",
                avatarName: "favorite.svg",
              ),
              onTap: () {
                Get.to(Favorites());
              },
            ),
            InkWell(
              child: _makeNavigationRecord(
                label: "Order History",
                avatarName: "history.svg",
              ),
              onTap: () {
                Get.to(OrderHistory());
              },
            ),
            InkWell(
              child: _makeNavigationRecord(
                label: "Help Center",
                avatarName: "help.svg",
              ),
              onTap: () {
                Get.to(HelpCenter());
              },
            ),
          ],
        ),
        bottomNavigationBar: Container(
          color: AppColors.grey50,
          height: 83,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                _makeNavBarIcon(iconName: "home.svg", label: "Home"),
                _makeNavBarIcon(iconName: "history.svg", label: "Category"),
                _makeNavBarIcon(iconName: "cart.svg", label: "Cart"),
                _makeNavBarIcon(iconName: "profile.svg", label: "Profile"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// make the icons of the bottom navigation bar.
Widget _makeNavBarIcon({required String iconName, required String label}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 30.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          "assets/images/$iconName",
          width: 20,
          height: 20,
          color: AppColors.grey500,
        ),
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
        ),
      ],
    ),
  );
}

// the records to navigat to the offers, history, favorites, ...
Widget _makeNavigationRecord({
  required String label,
  required String avatarName,
}) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.grey300,
            borderRadius: BorderRadius.circular(20),
          ),
          child: SvgPicture.asset(
            "assets/images/$avatarName",
            fit: BoxFit.scaleDown,
          ),
        ),
        SizedBox(width: 10),
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            fontFamily: "Roboto",
          ),
        ),
        Spacer(),
        Icon(Icons.arrow_forward_ios, color: AppColors.grey500),
      ],
    ),
  );
}

Widget _makeBottomSheetButton({
  required Color buttonColor,
  required Color labelColor,
  required String label,
}) {
  return Container(
    height: 50,
    width: double.infinity,
    decoration: BoxDecoration(
      color: buttonColor,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Center(
      child: Text(
        label,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: labelColor,
        ),
      ),
    ),
  );
}
