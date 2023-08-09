// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:new_user_side/features/project%20notes/view/widget/preview_project_notes.dart';
import 'package:new_user_side/provider/notifiers/estimate_notifier.dart';
import 'package:new_user_side/provider/notifiers/saved_notes_notifier.dart';
import 'package:new_user_side/res/common/my_app_bar.dart';
import 'package:new_user_side/res/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SavedNotesScreen extends StatefulWidget {
  static const String routeName = '/savedNotes';
  const SavedNotesScreen({super.key});

  @override
  State<SavedNotesScreen> createState() => _SavedNotesScreenState();
}

class _SavedNotesScreenState extends State<SavedNotesScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  bool isNoteForMe = true;
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final h = context.screenHeight;
    final w = context.screenWidth;
    final notifier = context.watch<EstimateNotifier>();
    final notesNotifier = context.watch<SavedNotesNotifier>();
    return ModalProgressHUD(
      inAsyncCall: notesNotifier.loading,
      child: Scaffold(
        appBar: MyAppBar(text: "Saved Notes"),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding:
                  EdgeInsets.symmetric(horizontal: w / 15, vertical: h / 60),
              color: AppColors.black,
              child: MyTextPoppines(
                text: notifier.projectDetails.services!.projectName.toString(),
                color: AppColors.white,
                fontSize: h / 40,
              ),
            ),
            Divider(thickness: 2.0, height: 8),
            3.vspacing(context),
            Row(
              children: [
                25.hspacing(context),
                MyTextPoppines(
                  text: "Estimate  No :",
                  fontSize: h / 50,
                  fontWeight: FontWeight.w600,
                ),
                15.hspacing(context),
                MyTextPoppines(
                  text: notifier.projectDetails.services!.estimateNo.toString(),
                  fontSize: h / 50,
                  fontWeight: FontWeight.w400,
                  color: AppColors.yellow,
                ),
              ],
            ),
            2.vspacing(context),
            Divider(thickness: 1.8),
            3.vspacing(context),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: w / 15),
              child: MyTextPoppines(
                text:
                    "Here’s the list of all your saved notes for this project that you have saved for You & Your Pro also.",
                fontSize: h / 60,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
              ),
            ),
            7.vspacing(context),
            Container(
              margin: EdgeInsets.symmetric(horizontal: w / 7),
              decoration: BoxDecoration(
                // color: Colors.black,
                border: Border.all(color: AppColors.black.withOpacity(0.2)),
                borderRadius: BorderRadius.circular(50.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                child: TabBar(
                  controller: tabController,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(60.0),
                    color: AppColors.golden,
                  ),
                  labelColor: Colors.white,
                  labelStyle: TextStyle(
                      fontSize: h / 80,
                      fontWeight: FontWeight.w500,
                      overflow: TextOverflow.ellipsis),
                  unselectedLabelColor: Colors.black.withOpacity(0.6),
                  tabs: const [
                    Tab(text: "Saved Notes for Me"),
                    Tab(text: "Saved Notes from Pro"),
                  ],
                ),
              ),
            ),
            notesNotifier.loading
                ? SizedBox()
                : Expanded(
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        SavedNotesBlock(),
                        SavedNotesBlock2(),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

class SavedNotesBlock extends StatelessWidget {
  const SavedNotesBlock({super.key});

  @override
  Widget build(BuildContext context) {
    final h = context.screenHeight;
    final w = context.screenWidth;
    final notifier = context.watch<SavedNotesNotifier>();
    final notes = notifier.savedNotes.notes!;
    return notifier.loading
        ? Center(child: CircularProgressIndicator())
        : ListView.builder(
            shrinkWrap: true,
            itemCount: notes.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.black.withOpacity(0.2),
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                padding:
                    EdgeInsets.symmetric(vertical: h / 90, horizontal: w / 60),
                margin:
                    EdgeInsets.symmetric(vertical: h / 50, horizontal: w / 30),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: SizedBox(
                        width: w / 3,
                        height: h / 10,
                        child: notes[index].images == null
                            ? Image.asset(
                                "assets/images/image_not_found.png",
                                fit: BoxFit.cover,
                              )
                            : CachedNetworkImage(
                                imageUrl:
                                    notes[index].images!.first.thumbnailUrl!,
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                  "assets/images/image_not_found.png",
                                  fit: BoxFit.cover,
                                ),
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                      colorFilter: ColorFilter.mode(
                                        Colors.red,
                                        BlendMode.colorBurn,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                      ),
                    ),
                    10.hspacing(context),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: SizedBox(
                            height: h / 14,
                            width: w / 2.0,
                            child: MyTextPoppines(
                              text: notes[index].note.toString(),
                              fontSize: h / 80,
                              fontWeight: FontWeight.w500,
                              maxLines: 5,
                              color: AppColors.black.withOpacity(0.8),
                            ),
                          ),
                        ),
                        2.vspacing(context),
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) =>
                                  PreviewProjectNotes(index: index),
                            );
                          },
                          child: Row(
                            children: [
                              MyTextPoppines(
                                text: "View",
                                fontSize: h / 75,
                                fontWeight: FontWeight.w600,
                                color: AppColors.buttonBlue,
                                textAlign: TextAlign.left,
                              ),
                              Icon(
                                Icons.arrow_forward,
                                color: AppColors.buttonBlue,
                                size: h / 70,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
  }
}

class SavedNotesBlock2 extends StatelessWidget {
  const SavedNotesBlock2({super.key});

  @override
  Widget build(BuildContext context) {
    final h = context.screenHeight;
    final w = context.screenWidth;
    final notifier = context.watch<SavedNotesNotifier>();

    return !notifier.loading
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: 0,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.black.withOpacity(0.2),
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: EdgeInsets.symmetric(
                  vertical: h / 70,
                  horizontal: w / 40,
                ),
                margin: EdgeInsets.symmetric(
                  vertical: h / 50,
                  horizontal: w / 30,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: w / 3,
                      height: h / 10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: AssetImage("assets/images/room/2(1).png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    10.hspacing(context),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: SizedBox(
                            height: h / 14,
                            width: w / 2.0,
                            child: MyTextPoppines(
                              text: "",
                              fontSize: h / 80,
                              fontWeight: FontWeight.w500,
                              maxLines: 5,
                              color: AppColors.black.withOpacity(0.8),
                            ),
                          ),
                        ),
                        2.vspacing(context),
                        InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return PreviewProjectNotes(index: index);
                                });
                          },
                          child: Row(
                            children: [
                              MyTextPoppines(
                                text: "View",
                                fontSize: h / 75,
                                fontWeight: FontWeight.w600,
                                color: AppColors.buttonBlue,
                                textAlign: TextAlign.left,
                              ),
                              Icon(
                                Icons.arrow_forward,
                                color: AppColors.buttonBlue,
                                size: h / 70,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          )
        : Center(child: Center(child: CircularProgressIndicator()));
  }
}
