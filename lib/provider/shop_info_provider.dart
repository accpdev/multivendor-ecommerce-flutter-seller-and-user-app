
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/data/model/response/base/api_response.dart';
import 'package:sixvalley_vendor_app/data/model/response/response_model.dart';
import 'package:sixvalley_vendor_app/data/model/response/shop_info_model.dart';
import 'package:sixvalley_vendor_app/data/repository/shop_info_repo.dart';
import 'package:sixvalley_vendor_app/helper/api_checker.dart';
import 'package:http/http.dart' as http;
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/main.dart';
import 'package:sixvalley_vendor_app/provider/auth_provider.dart';
import 'package:sixvalley_vendor_app/view/base/custom_snackbar.dart';

class ShopProvider extends ChangeNotifier {
  final ShopRepo? shopRepo;

  ShopProvider({required this.shopRepo});


  int _selectedIndex = 0;
  int get selectedIndex =>_selectedIndex;

  updateSelectedIndex(int index){
    _selectedIndex = index;
    notifyListeners();
  }



  ShopModel? _shopModel;
  ShopModel? get shopModel => _shopModel;

  bool _isLoading = false;
  bool get isLoading => _isLoading;


  File? _file;

  File? get file => _file;
  final picker = ImagePicker();

  void choosePhoto() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 50, maxHeight: 500, maxWidth: 500);
    if (pickedFile != null) {
      _file = File(pickedFile.path);
    } else {
      if (kDebugMode) {
        print('No image selected.');
      }
    }
    notifyListeners();
  }

  bool vacationIsOn = false;

  void checkVacation(String vacationEndDate){
      DateTime vacationDate = DateTime.parse(vacationEndDate);
      final today = DateTime.now();
      final difference = vacationDate.difference(today).inDays;
      if(difference >=0 ){
        vacationIsOn = true;
      }else{
        vacationIsOn = false;
      }

  }


  Future<ResponseModel> getShopInfo() async {
    ResponseModel responseModel;
    ApiResponse apiResponse = await shopRepo!.getShop();
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _shopModel = ShopModel.fromJson(apiResponse.response!.data);
      responseModel = ResponseModel(true, 'successful');
      if(shopModel!.vacationEndDate != null){
        checkVacation(shopModel!.vacationEndDate!);
      }


    } else {
      String? errorMessage;
      if (apiResponse.error is String) {
        errorMessage = apiResponse.error.toString();
      } else {
        errorMessage = apiResponse.error.errors[0].message;
      }
      if (kDebugMode) {
        print(errorMessage);
      }
      responseModel = ResponseModel(false, errorMessage);
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
    return responseModel;
  }


  Future<ResponseModel> updateShopInfo(ShopModel updateShopModel, File? file) async {
    _isLoading = true;
    notifyListeners();

    ResponseModel responseModel;
    http.StreamedResponse response = await shopRepo!.updateShop(shopModel!, file,
        Provider.of<AuthProvider>(Get.context!, listen: false).shopBanner, Provider.of<AuthProvider>(Get.context!, listen: false).secondaryBanner);
    _isLoading = false;
    if (response.statusCode == 200) {
      Navigator.of(Get.context!).pop();
      showCustomSnackBar(getTranslated('shop_info_updated_successfully', Get.context!), Get.context!, isError: false);
      getShopInfo();
      String message = 'Success';
      _shopModel = updateShopModel;
      responseModel = ResponseModel(true, message);
      if (kDebugMode) {
        print(message);
      }
    } else {
      if (kDebugMode) {
        print('${response.statusCode} ${response.reasonPhrase}');
      }
      responseModel = ResponseModel(false, '${response.statusCode} ${response.reasonPhrase}');
    }
    notifyListeners();
    return responseModel;
  }

  Future<void> shopTemporaryClose(BuildContext context, int status) async {
    Navigator.of(context).pop();
    _isLoading = true;
    notifyListeners();
    ApiResponse apiResponse = await shopRepo!.temporaryClose(status);

    if (apiResponse.response!.statusCode == 200) {
      _isLoading = false;

      showCustomSnackBar(getTranslated('status_updated_successfully', Get.context!), Get.context!, isToaster: true, isError: false);
      getShopInfo();

    } else {
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();

  }
  Future<void> shopVacation(BuildContext context, String? startDate, String? endDate, vacationNote, int status) async {
    Navigator.of(context).pop();
    _isLoading = true;
    notifyListeners();
    ApiResponse apiResponse = await shopRepo!.vacation(startDate, endDate, vacationNote, status);

    if (apiResponse.response!.statusCode == 200) {
      _isLoading = false;
      showCustomSnackBar(getTranslated('status_updated_successfully', Get.context!), Get.context!, isToaster: true, isError: false);
      getShopInfo();

    } else {
      _isLoading = false;
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();

  }


  Future<ResponseModel> updateBankInfo(ShopModel updateUserModel, File file) async {
    _isLoading = true;
    notifyListeners();

    ResponseModel responseModel;
    http.StreamedResponse response = await shopRepo!.updateShop(updateUserModel, file,
        Provider.of<AuthProvider>(Get.context!, listen: false).shopBanner,
        Provider.of<AuthProvider>(Get.context!, listen: false).secondaryBanner);
    _isLoading = false;
    if (response.statusCode == 200) {
      String message = 'Success';
      _shopModel = updateUserModel;
      responseModel = ResponseModel(true, message);
      if (kDebugMode) {
        print(message);
      }
    } else {
      if (kDebugMode) {
        print('${response.statusCode} ${response.reasonPhrase}');
      }
      responseModel = ResponseModel(false, '${response.statusCode} ${response.reasonPhrase}',);
    }
    notifyListeners();
    return responseModel;
  }


  String getShopToken() {
    return shopRepo!.getShopToken();
  }


  final int _selectedItem = 0;
  int get selectedItem => _selectedItem;
  String _startDate = 'Start Date';
  String get startDate => _startDate;
  String _endDate = 'End Date';
  String get endDate => _endDate;


  Future <void> selectDate(BuildContext context,String startDate, String endDate) async {
    _startDate = startDate;
    _endDate = endDate;
    notifyListeners();
  }


}


