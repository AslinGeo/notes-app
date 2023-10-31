import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/constants/colors.dart';
import 'package:notes_app/constants/strings.dart';
import 'package:notes_app/pages/create_note/create.binding.dart';
import 'package:notes_app/pages/create_note/create.controller.dart';
import 'package:notes_app/pages/create_note/create.view.dart';
import 'package:notes_app/pages/home/home.controller.dart';
import 'package:notes_app/pages/view_note/view.controller.dart';
import 'package:notes_app/pages/view_note/view.view.dart';

class HomeView extends GetResponsiveView<HomeController> {
  HomeView({super.key}) {
    controller.init();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary,
      child: SafeArea(
        child: Obx(() => Scaffold(
              backgroundColor: AppColors.primary,
              appBar: myAppBar(),
              body: controller.notes.isEmpty ? emptyBody() : body(),
              floatingActionButton: floatingActionButton(),
            )),
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
                  Text(
                    AppStrings.notes,
                    style: GoogleFonts.nunito(
                        color: Colors.white,
                        fontSize: 43,
                        fontWeight: FontWeight.w600),
                    // style: const TextStyle(
                    //     color: Colors.white,
                    //     fontSize: 43,
                    //     fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    controller.searchNavigation();
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        color: AppColors.darkGrey,
                        borderRadius: BorderRadius.circular(15)),
                    child: const Center(
                      child: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 21,
                ),
                InkWell(
                  onTap: () {
                    dialogBox();
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        color: AppColors.darkGrey,
                        borderRadius: BorderRadius.circular(15)),
                    child: const Center(
                      child: Icon(
                        Icons.info_outline,
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

  emptyBody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Image(
            image: AssetImage("asset/emptyHome.png"),
            fit: BoxFit.fill,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            AppStrings.emptyBody,
            style: GoogleFonts.nunito(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w300),
          )
        ],
      ),
    );
  }

  floatingActionButton() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.lightGrey
            .withOpacity(0.4), // Background color of the FloatingActionButton
        boxShadow: [
          BoxShadow(
            color: AppColors.lightGrey
                .withOpacity(0.4), // Customize the shadow color here
            offset:
                const Offset(0, 3), // Change the shadow's position as needed
            blurRadius: 6, // Adjust the blur radius for the shadow
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.primary,
          boxShadow: [
            BoxShadow(
              color: AppColors.primary, // Color of the shadow
              offset: Offset(4, 4), // Offset of the shadow
              blurRadius: 10, // Spread of the shadow
              spreadRadius: 10, // Optional, adds more spread if greater than 0
            ),
          ],
        ),
        child: FloatingActionButton(
          backgroundColor: AppColors.primary,
          onPressed: () {
            Get.put(CreateController());
            Get.to(CreateView());
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  body() {
    return ListView.builder(
        itemCount: controller.notes.length,
        itemBuilder: ((context, index) {
          return noteTile(controller.notes[index]);
        }));
  }

  noteTile(data) {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0, right: 24, top: 24),
      child: InkWell(
        onLongPress: () {
          controller.selectNote.value = data;
          controller.notes.refresh();
        },
        onTap: () async {
          if (controller.selectNote.value["id"] == data["id"]) {
            await controller.deleteNote(data);
          } else {
            controller.viewNavigation(data);
          }
        },
        child: Container(
          decoration: BoxDecoration(
              color: controller.selectNote.value.isNotEmpty &&
                      controller.selectNote["id"] == data["id"]
                  ? Colors.red
                  : controller.generateRandomColor(),
              borderRadius: BorderRadius.circular(15)),
          child: Center(
              child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: controller.selectNote.value.isNotEmpty &&
                    controller.selectNote["id"] == data["id"]
                ? Icon(
                    Icons.delete,
                    color: Colors.white,
                  )
                : Text(
                    data["title"],
                    style: GoogleFonts.nunito(
                        color: AppColors.blackDark,
                        fontSize: 20,
                        fontWeight: FontWeight.w400),
                  ),
          )),
        ),
      ),
    );
  }

  dialogBox() {
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
          title: Text(
            AppStrings.madeBy,
            style: GoogleFonts.nunito(
                color: AppColors.lightGrey03,
                fontSize: 23,
                fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
          content: Text(
            "Aslin Geo",
            style: GoogleFonts.nunito(
                color: AppColors.lightGrey03,
                fontSize: 20,
                fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }
}
