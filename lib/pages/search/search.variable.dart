import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../constants/debouncer.dart';

class SearchVariables {
  TextEditingController searchController = TextEditingController();
  RxString searchText = "".obs;
  RxList notes = [].obs;
  RxList searchList = [].obs;
  final debouncer = Debouncer(milliseconds: 500);
  RxBool isSearch = false.obs;
  RxBool isNetworkAvailable = false.obs;
}
