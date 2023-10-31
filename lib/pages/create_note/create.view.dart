import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/constants/colors.dart';
import 'package:notes_app/constants/snack_bar.dart';
import 'package:notes_app/constants/strings.dart';
import 'package:notes_app/pages/create_note/create.controller.dart';
import 'package:notes_app/pages/home/home.controller.dart';

class CreateView extends GetResponsiveView<CreateController> {
  Map? note;

  CreateView({super.key, this.note}) {
    if (note != null) {
      controller.note.value = note!;
    }
    controller.init();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.primary,
          appBar: myAppBar(),
          body: body(),
        ),
      ),
    );
  }

  myAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(70.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      // dialogBox(true);
                      if (controller.titleController.text == "" &&
                          controller.descriptionController.text == "") {
                        Get.back();
                      } else {
                        dialogBox(true);
                      }
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: AppColors.darkGrey,
                          borderRadius: BorderRadius.circular(15)),
                      child: const Center(
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: AppColors.darkGrey,
                      borderRadius: BorderRadius.circular(15)),
                  child: const Center(
                    child: Icon(
                      Icons.remove_red_eye_outlined,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 21,
                ),
                InkWell(
                  onTap: () async {
                    dialogBox(false);
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        color: AppColors.darkGrey,
                        borderRadius: BorderRadius.circular(15)),
                    child: const Center(
                      child: Icon(
                        Icons.save,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 25,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  body() {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24),
      child: ListView(
        children: [
          const SizedBox(
            height: 40,
          ),
          TextFormField(
            autofocus: true,
            controller: controller.titleController,
            enabled: true,
            cursorColor: Colors.white,
            keyboardType: TextInputType.multiline,
            style: GoogleFonts.nunito(
                color: Colors.white, fontSize: 35, fontWeight: FontWeight.w400),
            maxLines: 1,
            textInputAction: TextInputAction.newline,
            decoration: InputDecoration(
                hintStyle: GoogleFonts.nunito(
                    color: AppColors.lightGrey,
                    fontSize: 48,
                    fontWeight: FontWeight.w400),
                hintText: AppStrings.titleHintText,
                border: InputBorder.none),
          ),
          TextFormField(
            controller: controller.descriptionController,
            enabled: true,
            cursorColor: Colors.white,
            keyboardType: TextInputType.multiline,
            style: GoogleFonts.nunito(
                color: Colors.white, fontSize: 23, fontWeight: FontWeight.w400),
            maxLines: 1,
            textInputAction: TextInputAction.newline,
            decoration: InputDecoration(
                hintText: AppStrings.descriptionHintText,
                hintStyle: GoogleFonts.nunito(
                    color: AppColors.lightGrey,
                    fontSize: 23,
                    fontWeight: FontWeight.w400),
                border: InputBorder.none),
          )
        ],
      ),
    );
  }

  dialogBox(bool isDelete) {
    return showDialog(
      barrierColor: AppColors.lightGrey.withOpacity(0.2),
      context: Get.context!,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(20.0), // Adjust the radius as needed
          ),
          icon: Icon(
            Icons.info,
            color: AppColors.darkGrey02,
          ),
          content: Text(
            isDelete ? AppStrings.deleteText : AppStrings.saveText,
            style: GoogleFonts.nunito(
                color: AppColors.lightGrey03,
                fontSize: 23,
                fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    // Add your action for the "Discard" button here
                    controller.descriptionController.text = "";
                    controller.titleController.text = "";
                    Get.back();
                    Get.back();
                  },
                  // ignore: sort_child_properties_last
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    child: Text(AppStrings.discard,
                        style: const TextStyle(color: Colors.white)),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                TextButton(
                  onPressed: () async {
                    // Add your action for the "Keep" or "Save" button here
                    controller.saveNote(isDelete);
                  },
                  // ignore: sort_child_properties_last
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    child: Text(isDelete ? AppStrings.keep : AppStrings.save,
                        // ignore: prefer_const_constructors
                        style: TextStyle(color: Colors.white)),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
