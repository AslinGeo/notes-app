import 'package:get/get.dart';
import 'package:notes_app/pages/search/search.controller.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SearchController());
  }
}
