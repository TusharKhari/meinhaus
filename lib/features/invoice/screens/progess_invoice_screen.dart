// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:new_user_side/features/check%20out/screens/checkout_screen.dart';
import 'package:new_user_side/provider/notifiers/estimate_notifier.dart';
import 'package:new_user_side/resources/common/my_app_bar.dart';
import 'package:new_user_side/resources/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:provider/provider.dart';
import '../../../data/models/progress_invoice_model.dart';
import '../../../resources/font_size/font_size.dart';

class ProgressInvoiceScreen extends StatelessWidget {
  static const String routeName = '/progess-invoice';
  const ProgressInvoiceScreen({
    Key? key,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<EstimateNotifier>();
    final projectDetails = notifier.projectDetails.services!;
    final width = context.screenWidth;
    final height = context.screenHeight;
    final invoice = notifier.progressInvoiceModel.data;
    final billFrom = invoice?.meinhausAddress!;
    final billTo = invoice?.billTo!.address!;
    final totalDueAmount = invoice?.amountToBePaid!.totalAmountDue!.split(".");
    final bool amountPaid = totalDueAmount?[0] == "0";
 final size = MediaQuery.of(context).size;
    return !notifier.loading
        ? ModalProgressHUD(
            inAsyncCall: notifier.loading,
            child: Scaffold(
              appBar: MyAppBar(text: "Progress Invoice"),
              body: SafeArea(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: width / 3.6,
                        height: height / 23,
                        child: Image.asset(
                          "assets/logo/invoice_logo.png",
                          fit: BoxFit.fill,
                        ),
                      ),
                      4.vspacing(context),
                      Expanded(
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              1.vspacing(context),
                              // Estimate
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyTextPoppines(
                                    text: "PROJECT",
                                    // text: "ESTIMATE",
                                    fontSize:20.sp,
                                    height: 1.5,
                                    textAlign: TextAlign.end,
                                    fontWeight: FontWeight.w700,
                                    color: const Color.fromARGB(255, 132, 5, 5),
                                  ),
                                  MyTextPoppines(
                                    text:
                                        "Project Number : ${invoice?.bookingId}",
                                        // "Estimate Number : ${invoice?.bookingId}",
                                    fontSize:18.sp,
                                    // fontSize:size.height * FontSize.sixteen,
                                    height: 1.5,
                                    textAlign: TextAlign.start,
                                  ),
                                  MyTextPoppines(
                                    text:
                                        "Project Date : ${invoice!.createdAt}",
                                        // "Estimate Date : ${invoice!.createdAt}",
                                    fontSize:18.sp,
                                    // fontSize:size.height * FontSize.sixteen,
                                    height: 1.5,
                                    textAlign: TextAlign.start,
                                  ),
                                  MyTextPoppines(
                                    text:
                                        "Grand Total (CAD) : \$${invoice.totalAmount}",
                                    fontSize:18.sp,
                                    // fontSize:size.height * FontSize.sixteen,
                                    height: 1.5,
                                    textAlign: TextAlign.start,
                                  ),
                                ],
                              ),
                              5.vspacing(context),
                              // Bill from
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyTextPoppines(
                                    text: "Mein Haus",
                                    fontSize: 20.sp,
                                    // fontSize: width / 25,
                                    height: 1.5,
                                    textAlign: TextAlign.end,
                                    fontWeight: FontWeight.w500,
                                    color: const Color.fromARGB(255, 132, 5, 5),
                                  ),
                                  MyTextPoppines(
                                    text: billFrom!.address1.toString(),
                                   fontSize:18.sp,
                                    // fontSize:size.height * FontSize.sixteen,
                                    height: 1.5,
                                  ),
                                  1.vspacing(context),
                                  MyTextPoppines(
                                    text:
                                        "${billFrom.city}, ${billFrom.province} ${billFrom.postalCode}",
                                    fontSize:18.sp,
                                    // fontSize:size.height * FontSize.sixteen,
                                    height: 1.5,
                                  ),
                                  1.vspacing(context),
                                  MyTextPoppines(
                                    text: billFrom.country.toString(),
                                    fontSize:18.sp,
                                    // fontSize:size.height * FontSize.sixteen,
                                    height: 1.5,
                                  ),
                                  1.vspacing(context),
                                  MyTextPoppines(
                                    text: "+${billFrom.phone}",
                                    fontSize:18.sp,
                                    // fontSize:size.height * FontSize.sixteen,
                                    height: 1.5,
                                    textAlign: TextAlign.start,
                                  ),
                                  1.vspacing(context),
                                  MyTextPoppines(
                                    text: billFrom.website.toString(),
                                    fontSize:18.sp,
                                    // fontSize:size.height * FontSize.sixteen,
                                    height: 1.5,
                                    textAlign: TextAlign.start,
                                    color: AppColors.textBlue,
                                  ),
                                ],
                              ),
                              5.vspacing(context),
                              // Bill to
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyTextPoppines(
                                    text: "Bill To",
                                    fontSize:19.sp,
                                    // fontSize: width / 25,
                                    height: 1.5,
                                    textAlign: TextAlign.end,
                                    fontWeight: FontWeight.w500,
                                    color: const Color.fromARGB(255, 132, 5, 5),
                                  ),
                                  MyTextPoppines(
                                    text: invoice.billTo!.name.toString(),
                                   fontSize:size.height * FontSize.sixteen,
                                    // fontSize: size.height * FontSize.sixteen,
                                    height: 1.5,
                                    fontWeight: FontWeight.w600,
                                    textAlign: TextAlign.end,
                                  ),
                                  1.vspacing(context),
                                  MyTextPoppines(
                                    text: billTo!.address1.toString().trim(),
                                   fontSize:size.height * FontSize.sixteen,
                                    // fontSize:size.height * FontSize.sixteen,
                                    height: 1.5,
                                    textAlign: TextAlign.start,
                                  ),
                                  1.vspacing(context),
                                  MyTextPoppines(
                                    text: billTo.address2.toString().trim(),
                                   fontSize:size.height * FontSize.sixteen,
                                    // fontSize:size.height * FontSize.sixteen,
                                    height: 1.5,
                                    textAlign: TextAlign.start,
                                  ),
                                  1.vspacing(context),
                                  MyTextPoppines(
                                    text: billTo.city.toString(),
                                  fontSize:size.height * FontSize.sixteen,
                                    // fontSize:size.height * FontSize.sixteen,
                                    height: 1.5,
                                    textAlign: TextAlign.start,
                                  ),
                                  1.vspacing(context),
                                  MyTextPoppines(
                                    text: "${billTo.state}, ${billTo.country}",
                                  fontSize:size.height * FontSize.sixteen,
                                    // fontSize:size.height * FontSize.sixteen,
                                    height: 1.5,
                                    textAlign: TextAlign.start,
                                  ),
                                  1.vspacing(context),
                                  MyTextPoppines(
                                    text: invoice.billTo!.phone.toString(),
                                   fontSize:size.height * FontSize.sixteen,
                                    // fontSize:size.height * FontSize.sixteen,
                                    height: 1.5,
                                    textAlign: TextAlign.start,
                                  ),
                                  1.vspacing(context),
                                  MyTextPoppines(
                                    text: invoice.billTo!.email.toString(),
                                    fontSize:size.height * FontSize.sixteen,
                                    // fontSize:size.height * FontSize.sixteen,
                                    height: 1.5,
                                    textAlign: TextAlign.start,
                                  ),
                                ],
                              ),
                              5.vspacing(context),
                              _ShowTableView(),
                              5.vspacing(context),
                              _ShowInvoiceSummary(),
                              5.vspacing(context),
                              _ShowAmountToPaid(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: InkWell(
                onTap: amountPaid
                    ? () {}
                    : () {
                    
                   String d=   invoice.amountToBePaid?.totalAmountDue ?? "";
                      String am="";
                    var a=  d.split(",");
                    a.forEach((element) {
                      am +=element;
                     });
                   
                        Navigator.of(context).pushScreen(
                          CheckOutScreen(
                            ProjectName: projectDetails.projectName.toString(),
                            bookingId: invoice.bookingId.toString(),
                            amountToPay: am
                          ),
                        );
                      },
                child: Container(
                  width: width / 1.5,
                  height: height / 18,
                  color: amountPaid ? AppColors.green : AppColors.golden,
                  child: Center(
                      child: MyTextPoppines(
                    text: amountPaid ? "Paid" : "Pay",
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  )),
                ),
              ),
            ),
          )
        : ModalProgressHUD(
            inAsyncCall: true,
            child: Scaffold(),
          );
  }
}

class _ShowTableView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<EstimateNotifier>().progressInvoiceModel;
    final invoice = notifier.data!;
     final size = MediaQuery.of(context).size;
    return Table(
      border: TableBorder.all(),
      columnWidths: {
        0: FractionColumnWidth(0.25),
        1: FractionColumnWidth(0.23),
        2: FractionColumnWidth(0.18),
        3: FractionColumnWidth(0.18),
        4: FractionColumnWidth(0.15),
      },
      children: [
        buildHeaderRow([
          "Project Area",
          "Description",
          "Deposit Amount",
          "Project Cost",
          "Due",
        ]),
        for (var service in invoice.services!) _buildRow(service, invoice, size),
      ],
    );
  }

  TableRow _buildRow(Services service, Data invoice, Size size) => TableRow(
        children: [
          buildCell(service.serviceName ?? "",size,  isBold: true),
          buildCell(service.description ?? "", size),
          buildCell(
              "\$${invoice.invoiceSummary!.totalAmountPaid!}", size),
           buildCell("\$${invoice.totalAmount!}", size),
           buildCell("\$${service.amountToPay!}", size),
        ],
      );

  Widget buildCell(String value,Size size,  {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.only(left: 6, top: 4, bottom: 4),
      child: MyTextPoppines(
        text: value,
        fontSize: size.height * FontSize.twelve,
        fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
        textAlign: TextAlign.start,
        maxLines: 100,
      ),
    );
  }

  TableRow buildHeaderRow(List<String> cells) => TableRow(
        children: cells.map((cell) {
          return Container(
            height: 45.h,
            padding: const EdgeInsets.all(8.0),
            color: AppColors.golden,
            child: MyTextPoppines(
              text: cell,
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.black,
            ),
          );
        }).toList(),
      );
}

class _ShowInvoiceSummary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final notifier = context.read<EstimateNotifier>().progressInvoiceModel;
    final invoice = notifier.data!.invoiceSummary!;
    final width = context.screenWidth;
     final size = MediaQuery.of(context).size;
    return SizedBox(
      width: width / 1.15,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyTextPoppines(
            text: "Invoice Summary",
           fontSize:size.height * FontSize.sixteen,
            // fontSize: width / 33,
            fontWeight: FontWeight.w700,
          ),
          Divider(thickness: 1.0),
          _buildInvoiceRow(
            context: context,
            heading: "Total Amount Paid",
            amount: invoice.totalAmountPaid.toString(),
          ),
          1.vspacing(context),
          _buildInvoiceRow(
            context: context,
            heading: "Remaining Amount to be Paid",
            amount: invoice.remainingAmountToBePaid.toString(),
          ),
          1.vspacing(context),
          _buildInvoiceRow(
            context: context,
            heading: "Total Project Cost",
            amount: invoice.totalProjectCost.toString(),
          ),
          1.vspacing(context),
          _buildInvoiceRow(
            context: context,
            heading: "HST 13%",
            amount: invoice.hst.toString(),
          ),
          1.vspacing(context),
          _buildInvoiceRow(
            context: context,
            heading: "Invoice Total",
            amount: invoice.invoiceTotal.toString(),
          ),
        ],
      ),
    );
  }

  Widget _buildInvoiceRow({
    required BuildContext context,
    required String heading,
    required String amount,
  }) {
     final size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MyTextPoppines(
          text: heading,
         fontSize:size.height * FontSize.sixteen,
          // fontSize: context.screenWidth / 35,
        ),
        MyTextPoppines(
          text: "\$$amount",
        fontSize:size.height * FontSize.sixteen,
          // fontSize: context.screenWidth / 35,
        ),
      ],
    );
  }
}

class _ShowAmountToPaid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final notifier = context.read<EstimateNotifier>().progressInvoiceModel;
    final invoice = notifier.data!.amountToBePaid!;
    final width = context.screenWidth;
     final size = MediaQuery.of(context).size;
    return SizedBox(
      width: width / 1.15,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyTextPoppines(
            text: "Amount to be Paid",
            fontSize:size.height * FontSize.sixteen,
            // fontSize: size.height * FontSize.sixteen,
            fontWeight: FontWeight.w700,
          ),
          Divider(thickness: 1.0),
          _buildInvoiceRow(
            context: context,
            heading: "Remaining Project Cost",
            amount: invoice.remainingProjectCost.toString(),
          ),
          1.8.vspacing(context),
          _buildInvoiceRow(
            context: context,
            heading: "HST %",
            amount: invoice.hst.toString(),
          ),
          1.8.vspacing(context),
          _buildInvoiceRow(
            context: context,
            heading: "Total Amount due",
            amount: invoice.totalAmountDue.toString(),
          ),
        ],
      ),
    );
  }

  Widget _buildInvoiceRow({
    required BuildContext context,
    required String heading,
    required String amount,
  }) {
     final size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MyTextPoppines(
          text: heading,
          fontSize:size.height * FontSize.sixteen,
          // fontSize: context.screenWidth / 35,
        ),
        MyTextPoppines(
          text: "\$$amount",
        fontSize:size.height * FontSize.sixteen,
          // fontSize: context.screenWidth / 35,
        ),
      ],
    );
  }
}
