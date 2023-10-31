import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CreateVariables {
  TextEditingController descriptionController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  RxMap note = {}.obs;
  RxBool isNetworkAvailable = false.obs;
}
