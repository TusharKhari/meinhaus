// ignore_for_file: public_member_api_docs, sort_constructors_first


// class AddAdressDialog extends StatelessWidget {
//   const AddAdressDialog({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     return Dialog(
//       backgroundColor: Colors.transparent,
//       elevation: 0.0,
//       child: SingleChildScrollView(
//         child: Container(
//           height: height / 1.77,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(14.r),
//             color: AppColors.white,
//           ),
//           padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 10.w),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     MyTextPoppines(
//                       text: "Enter Your Address",
//                       fontSize: context.screenHeight / MyFontSize.font12,
//                       fontWeight: FontWeight.w600,
//                       height: 1.8,
//                       textAlign: TextAlign.center,
//                       color: AppColors.black.withOpacity(0.8),
//                     ),
//                     InkWell(
//                       onTap: () => Navigator.pop(context),
//                       child: CircleAvatar(
//                         radius: 10.r,
//                         backgroundColor: AppColors.textBlue.withOpacity(0.15),
//                         child: Icon(
//                           CupertinoIcons.xmark,
//                           size: 12.sp,
//                           color: AppColors.black,
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               const Divider(thickness: 1.0),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 10.w),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     AddAddressDialogTextField(
//                       text: "Enter Address",
//                       hintText: "Enter Your Address Here",
//                       maxLines: 3,
//                     ),
//                     Align(
//                       alignment: Alignment(1, 0.0),
//                       child: MyBlueButton(
//                         hPadding: 10.w,
//                         vPadding: 8.h,
//                         isRoundedBorder: false,
//                         text: "Add Address",
//                         fontSize: 10.w,
//                         onTap: () {},
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               10.vs,
//               // Divider Or lines
//               Row(
//                 children: [
//                   Expanded(
//                     child: Container(
//                       margin: EdgeInsets.symmetric(horizontal: 8.w),
//                       height: 0.6.h,
//                       color: AppColors.black.withOpacity(0.3),
//                     ),
//                   ),
//                   MyTextPoppines(
//                     text: "Or",
//                     fontSize: height / MyFontSize.font10,
//                     fontWeight: FontWeight.bold,
//                     color: AppColors.black.withOpacity(0.7),
//                   ),
//                   Expanded(
//                     child: Container(
//                       margin: EdgeInsets.symmetric(horizontal: 8.w),
//                       height: 0.6.h,
//                       color: AppColors.black.withOpacity(0.3),
//                     ),
//                   ),
//                 ],
//               ),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 10.w),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         Expanded(
//                           child: AddAddressDialogTextField(
//                             text: "State",
//                           ),
//                         ),
//                         15.hs,
//                         Expanded(
//                           child: AddAddressDialogTextField(
//                             text: "City/Village",
//                           ),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: AddAddressDialogTextField(
//                             text: "Street Name",
//                           ),
//                         ),
//                         15.hs,
//                         Expanded(
//                           child: AddAddressDialogTextField(
//                             text: "Nearby Places",
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               const Divider(thickness: 1.0),
//               5.vs,
//               Align(
//                 alignment: Alignment(0.9, 0.0),
//                 child: MyBlueButton(
//                   hPadding: 10.w,
//                   vPadding: 8.h,
//                   isRoundedBorder: false,
//                   text: "Add Address",
//                   fontSize: 10.w,
//                   onTap: () {},
//                 ),
//               ),
//               5.vs,
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class AddAddressDialogTextField extends StatelessWidget {
//   final String text;
//   final int? maxLines;
//   final double? width;
//   final String? hintText;
//   const AddAddressDialogTextField({
//     Key? key,
//     required this.text,
//     this.maxLines = 1,
//     this.width,
//     this.hintText = '',
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 10.h),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           MyTextPoppines(
//             text: " $text",
//             fontWeight: FontWeight.w500,
//             fontSize: 10.sp,
//             maxLines: 1,
//           ),
//           10.vs,
//           Container(
//             width: width ?? double.infinity,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(8.r),
//               color: const Color.fromARGB(194, 240, 240, 240),
//             ),
//             child: TextFormField(
//               maxLines: maxLines,
//               style: TextStyle(fontSize: 12.sp),
//               decoration: InputDecoration(
//                 contentPadding: EdgeInsets.symmetric(
//                   horizontal: 10.w,
//                   vertical: 4.h,
//                 ),
//                 border: InputBorder.none,
//                 hintText: hintText,
//                 hintStyle: GoogleFonts.poppins(
//                   color: AppColors.grey.withOpacity(0.9),
//                   fontSize: 10.sp,
//                   fontWeight: FontWeight.w400,
//                   height: 1.5,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
