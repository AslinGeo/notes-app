import 'dart:convert';
import 'dart:math';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:notes_app/constants/api_urls.dart';
import 'package:notes_app/constants/snack_bar.dart';
import 'package:notes_app/pages/home/home.variable.dart';
import 'package:http/http.dart' as http;
import 'package:notes_app/pages/search/search.controller.dart';
import 'package:notes_app/pages/search/search.view.dart';
import 'package:notes_app/pages/view_note/view.controller.dart';
import 'package:notes_app/pages/view_note/view.view.dart';

class HomeController extends GetxController with HomeVariables {
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
  }

  init() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      isNetworkAvailable.value = false;
    } else {
      isNetworkAvailable.value = true;
    }
    await getNotes();
  }

  getNotes() async {
    if (!isNetworkAvailable.value) {
      return SnackbarUtils.instance.failureSnackbar("No Network Connection");
    }
    Map<String, String>? header = {};
    header["Content-Type"] = "application/json";
    try {
      final response =
          await http.get(Uri.parse(ApiUrls.baseUrl), headers: header);
      final responsebody = json.decode(response.body);
      notes.value = responsebody["data"];
    } catch (e) {
      SnackbarUtils.instance.failureSnackbar(e.toString());
    }
  }

  Color generateRandomColor() {
    final Random random = Random();
    final int r = random.nextInt(256); // Red component (0-255)
    final int g = random.nextInt(256); // Green component (0-255)
    final int b = random.nextInt(256); // Blue component (0-255)

    return Color.fromARGB(255, r, g, b); // Create a Color object
  }

  deleteNote(note) async {
    if (!isNetworkAvailable.value) {
      return SnackbarUtils.instance.failureSnackbar("No Network Connection");
    }
    Map<String, String>? header = {};
    header["Content-Type"] = "application/json";
    try {
      final response = await http.delete(
          Uri.parse("${ApiUrls.baseUrl}/${note["id"]}"),
          headers: header);
      notes.remove(note);
      notes.refresh();
    } catch (e) {
      SnackbarUtils.instance.failureSnackbar(e.toString());
    }
  }

  viewNavigation(data) async {
    Get.put(ViewController());
    await Get.to(ViewView(
      note: data,
    ));
    getNotes();
  }

  searchNavigation() {
    Get.put(SearchController());
    Get.to(SearchView());
  }
}
