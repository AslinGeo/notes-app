import 'package:get/get.dart';
import 'package:notes_app/pages/create_note/create.controller.dart';

class CreateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreateController());
  }
}
