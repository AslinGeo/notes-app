import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/constants/colors.dart';
import 'package:notes_app/constants/strings.dart';
import 'package:notes_app/pages/home/home.view.dart';
import 'package:notes_app/pages/search/search.controller.dart';

class SearchView extends GetResponsiveView<SearchPageController> {
  SearchView({super.key}) {
    controller.init();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary,
      child: SafeArea(
          child: Scaffold(
        backgroundColor: AppColors.primary,
        body: Obx(() => body()),
      )),
    );
  }

  body() {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 24, right: 24),
          child: Container(
            padding: const EdgeInsets.only(
              left: 30,
            ),
            width: MediaQuery.of(Get.context!).size.width * 0.90,
            decoration: BoxDecoration(
                color: AppColors.darkGrey,
                borderRadius: BorderRadius.circular(30)),
            child: TextField(
              onChanged: (value) {
                if (value.isNotEmpty) {
                  controller.isSearch.value = true;
                }
                controller.debouncer.run(() => controller.search(value));
              },
              // autofocus: true,
              controller: controller.searchController,
              style: GoogleFonts.nunito(
                  color: AppColors.lightGrey02,
                  fontSize: 20,
                  fontWeight: FontWeight.w300),
              decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 5.0),
                  // prefixIconConstraints: BoxConstraints(maxWidth: 20),

                  suffix: controller.isSearch.value
                      ? InkWell(
                          onTap: () {
                            controller.clearSearch();
                          },
                          child: const Padding(
                              padding: EdgeInsets.only(left: 6, right: 6),
                              child: Icon(
                                Icons.close,
                                color: Colors.white,
                              )),
                        )
                      : Container(width: 0, height: 0),
                  hintText: AppStrings.searchText,
                  hintStyle: GoogleFonts.nunito(
                      color: AppColors.lightGrey02,
                      fontSize: 20,
                      fontWeight: FontWeight.w300),
                  border: InputBorder.none,
                  labelStyle: GoogleFonts.nunito(
                      color: AppColors.lightGrey02,
                      fontSize: 20,
                      fontWeight: FontWeight.w300)),
            ),
          ),
        ),
        Expanded(
            child: controller.isSearch.value && controller.searchList.isEmpty
                ? emptyBody()
                : controller.searchList.isNotEmpty
                    ? searchList()
                    : Container())
      ],
    );
  }

  searchList() {
    return ListView.builder(
        itemCount: controller.searchList.length,
        itemBuilder: ((context, index) {
          return HomeView().noteTile(controller.searchList[index]);
        }));
  }

  emptyBody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Image(
            image: AssetImage("asset/emptySearch.png"),
            fit: BoxFit.fill,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            AppStrings.searchEmptyText,
            style: GoogleFonts.nunito(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w300),
          )
        ],
      ),
    );
  }
}
