import 'package:a_8085_helper/res/app_strings.dart';
import 'package:get/get.dart';

class ApiCalls extends GetConnect {
  Future<Response> getVideos() => get(AppStrings.videoEndpoint);
}