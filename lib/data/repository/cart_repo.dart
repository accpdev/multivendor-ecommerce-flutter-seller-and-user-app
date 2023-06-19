import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sixvalley_vendor_app/data/datasource/remote/dio/dio_client.dart';
import 'package:sixvalley_vendor_app/data/datasource/remote/exception/api_error_handler.dart';
import 'package:sixvalley_vendor_app/data/model/body/customer_body.dart';
import 'package:sixvalley_vendor_app/data/model/body/place_order_body.dart';
import 'package:sixvalley_vendor_app/data/model/response/base/api_response.dart';
import 'package:sixvalley_vendor_app/utill/app_constants.dart';


class CartRepo{
  final DioClient? dioClient;
  final SharedPreferences? sharedPreferences;
  CartRepo({required this.dioClient, required this.sharedPreferences});


  Future<ApiResponse> getCouponDiscount(String couponCode, int? userId, double orderAmount) async {
    try {
      final response = await dioClient!.post(AppConstants.getCouponDiscount,
      data: {
        'code' : couponCode,
        'user_id' : userId,
        'order_amount' : orderAmount
      });
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> placeOrder(PlaceOrderBody placeOrderBody) async {
    if (kDebugMode) {
      print('order place===>${placeOrderBody.toJson()}');
    }
    try {
      final response = await dioClient!.post(AppConstants.placeOrderUri, data: placeOrderBody.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<ApiResponse> getProductFromScan(String? productCode) async {
    try {
      final response = await dioClient!.get('${AppConstants.getProductFromProductCode}?code=$productCode');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<ApiResponse> getCustomerList() async {
    try {
      final response = await dioClient!.get(AppConstants.customerSearchUri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> customerSearch(String name) async {
    try {
      final response = await dioClient!.get('${AppConstants.customerSearchUri}?name=$name');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> addNewCustomer(CustomerBody customerBody) async {
    try {
      final response = await dioClient!.post(AppConstants.addNewCustomer,
          data: {
            'f_name' : customerBody.fName,
            'l_name' : customerBody.lName,
            'email' : customerBody.email,
            'phone' : customerBody.phone,
            'country' : customerBody.country,
            'city' : customerBody.city,
            'zip_code' : customerBody.zipCode,
            'address' : customerBody.address,
          });
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }



}