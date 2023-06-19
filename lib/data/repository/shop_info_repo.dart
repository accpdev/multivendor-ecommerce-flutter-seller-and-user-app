
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sixvalley_vendor_app/data/datasource/remote/dio/dio_client.dart';
import 'package:sixvalley_vendor_app/data/datasource/remote/exception/api_error_handler.dart';
import 'package:sixvalley_vendor_app/data/model/response/base/api_response.dart';
import 'package:sixvalley_vendor_app/data/model/response/shop_info_model.dart';
import 'package:sixvalley_vendor_app/main.dart';
import 'package:sixvalley_vendor_app/provider/auth_provider.dart';
import 'package:sixvalley_vendor_app/utill/app_constants.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';

class ShopRepo {
  final DioClient? dioClient;
  final SharedPreferences? sharedPreferences;
  ShopRepo({required this.dioClient, required this.sharedPreferences});


  Future<ApiResponse> getShop() async {
    try {
      final response = await dioClient!.get(AppConstants.shopUri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }



  Future<http.StreamedResponse> updateShop(ShopModel userInfoModel,  File? file, XFile? shopBanner, XFile? secondaryBanner) async {
    http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse('${AppConstants.baseUrl}${AppConstants.shopUpdate}'));
    request.headers.addAll(<String,String>{'Authorization': 'Bearer ${Provider.of<AuthProvider>(Get.context!, listen: false).getUserToken()}'});
    if(file != null) {
      request.files.add(http.MultipartFile('logo', file.readAsBytes().asStream(), file.lengthSync(), filename: file.path.split('/').last));
    }
    if(shopBanner != null) {
      print('shop bannner ==>${shopBanner.path}');
      Uint8List list = await shopBanner.readAsBytes();
      var part = http.MultipartFile('banner', shopBanner.readAsBytes().asStream(), list.length, filename: basename(shopBanner.path));
      request.files.add(part);
    }if(secondaryBanner != null) {
      print('shop bannner ==>${secondaryBanner.path}');
      Uint8List list = await secondaryBanner.readAsBytes();
      var part = http.MultipartFile('bottom_banner', secondaryBanner.readAsBytes().asStream(), list.length, filename: basename(secondaryBanner.path));
      request.files.add(part);
    }
    Map<String, String> fields = {};
    fields.addAll(<String, String>{
      '_method': 'put', 'name': userInfoModel.name!, 'address': userInfoModel.address!, 'contact': userInfoModel.contact!
    });
    request.fields.addAll(fields);
    http.StreamedResponse response = await request.send();
    return response;
  }

  String getShopToken() {
    return sharedPreferences!.getString(AppConstants.token) ?? "";
  }


  Future<ApiResponse> vacation(String? startDate, String? endDate, vacationNote, int status) async {
    try {
      final response = await dioClient!.post(AppConstants.vacation,
      data: {
        "vacation_start_date" : startDate,
        "vacation_end_date" : endDate,
        "vacation_note" : vacationNote,
        "_method": "put",
        "vacation_status" : status
      });
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }



  Future<ApiResponse> temporaryClose(int status) async {
    try {
      final response = await dioClient!.post(AppConstants.temporaryClose,data: {
        '_method' : "put",
        'status' : status
      });
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


}