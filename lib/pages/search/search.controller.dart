import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/constants/api_urls.dart';
import 'package:notes_app/constants/loader.dart';
import 'package:notes_app/constants/snack_bar.dart';
import 'package:notes_app/pages/search/search.variable.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';

class SearchPageController extends GetxController with SearchVariables {
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  @override
  void dispose() {
    super.dispose();
    clearSearch();
  }

  init() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      isNetworkAvailable.value = false;
    } else {
      isNetworkAvailable.value = true;
    }

    clearSearch();
    getNotes();
  }

  getNotes() async {
    if (!isNetworkAvailable.value) {
      return SnackbarUtils.instance.failureSnackbar("No Network Connection");
    }
    Map<String, String>? header = {};
    header["Content-Type"] = "application/json";
    try {
      Loader().showOverlayLoader();
      final response =
          await http.get(Uri.parse(ApiUrls.baseUrl), headers: header);
      final responsebody = json.decode(response.body);
      notes.value = responsebody["data"];
      Navigator.pop(Get.context!);
    } catch (e) {
      SnackbarUtils.instance.failureSnackbar(e.toString());
    }
  }

  clearSearch() {
    isSearch.value = false;
    searchController.text = "";
    searchText.value = "";
    searchList.value = [];
  }

  search(String? text) {
    if (text == null || text.isEmpty) return;
    searchText.value = text;
    searchList.value = notes
        .where((ele) => ele["title"]
            .trim()
            .toLowerCase()
            .contains(searchText.value.trim().toLowerCase()))
        .toList();
    searchList.refresh();
  }
}
