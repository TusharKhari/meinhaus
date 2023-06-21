// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_user_side/features/address/screens/add_adress_screen.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:provider/provider.dart';

import '../../../provider/notifiers/address_notifier.dart';
import '../../../res/common/my_text.dart';
import '../../../provider/notifiers/auth_notifier.dart';
import 'address_card.dart';

class SavedAddressesWidget extends StatelessWidget {
  const SavedAddressesWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<AuthNotifier>();
    final address = userProvider.user.savedAddress;

    final height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                print(userProvider.user.savedAddress!.length);
              },
              child: MyTextPoppines(
                text: "Saved Address",
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
              ),
            ),
            Container(
              width: 120.w,
              height: 28.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18.r),
                border: Border.all(color: AppColors.buttonBlue),
              ),
              child: InkWell(
                onTap: () {
                  context.pushNamedRoute(AddAddressScreen.routeName);
                  // showDialog(
                  //   context: context,
                  //   builder: (context) {
                  //     return AddAdressDialog();
                  //   },
                  // );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 5.w, top: 2.h),
                      child: MyTextPoppines(
                        text: "Add Address",
                        fontWeight: FontWeight.w600,
                        fontSize: height > 800 ? 10.sp : 12.sp,
                        color: AppColors.buttonBlue,
                      ),
                    ),
                    Icon(
                      Icons.add_circle_outline_sharp,
                      size: height > 800 ? 16.sp : 18.sp,
                      color: AppColors.buttonBlue,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        20.vs,
        // Address
        (address != null && address.isNotEmpty)
            ? ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: userProvider.user.savedAddress!.length,
                itemBuilder: (context, index) {
                  final addressId = address[index].id;
                  return Consumer<AddressNotifier>(
                    builder: (context, selectedAddress, child) {
                      return InkWell(
                        onTap: () {
                          selectedAddress.setSelectedAddress(index);
                          print(addressId);
                        },
                        child: AddressCardWidget(
                          index: index,
                          isSelected: selectedAddress.index == index,
                          addressId: addressId!,
                        ),
                      );
                    },
                  );
                })
            : Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(width: 1.5, color: AppColors.black),
                ),
                padding: EdgeInsets.symmetric(horizontal: 80.w, vertical: 20.h),
                child: Center(
                  child: MyTextPoppines(
                    text: "No address found please add address 😔",
                    fontSize: 12.sp,
                    maxLines: 3,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

        30.vs,
      ],
    );
  }
}
