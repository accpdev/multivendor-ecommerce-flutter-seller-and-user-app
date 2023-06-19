import 'package:sixvalley_vendor_app/data/datasource/remote/dio/dio_client.dart';
import 'package:sixvalley_vendor_app/data/datasource/remote/exception/api_error_handler.dart';
import 'package:sixvalley_vendor_app/data/model/response/base/api_response.dart';
import 'package:sixvalley_vendor_app/data/model/response/shipping_model.dart';
import 'package:sixvalley_vendor_app/utill/app_constants.dart';
class ShippingRepo{
  final DioClient? dioClient;

  ShippingRepo({required this.dioClient});


  Future<ApiResponse> getShipping() async {
    try {
      final response = await dioClient!.get(AppConstants.shopUri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  Future<ApiResponse> getShippingMethod(String token) async {
    dioClient!.dio!.options.headers = {'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer $token'};

    try {
      final response = await dioClient!.get(AppConstants.getShippingUri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  Future<ApiResponse> addShipping(ShippingModel? shipping) async {
    try {
      final response = await dioClient!.post(AppConstants.addShippingUri,
          data: shipping);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  Future<ApiResponse> updateShipping(String? title,String? duration,double? cost, int? id) async {
    try {
      final response = await dioClient!.post('${AppConstants.updateShippingUri}/$id',
          data: {'_method': 'put','title' : title, 'duration' : duration, 'cost' : cost});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  Future<ApiResponse> deleteShipping(int? id) async {
    try {
      final response = await dioClient!.delete('${AppConstants.deleteShippingUri}/$id');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getCategoryWiseShippingMethod() async {
    try {
      final response = await dioClient!.get(AppConstants.showShippingCostUri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getSelectedShippingMethodType() async {
    try {
      final response = await dioClient!.get(AppConstants.getShippingMethodTypeUri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  Future<ApiResponse> setShippingMethodType( String? type) async {
    try {
      final response = await dioClient!.get('${AppConstants.setShippingMethodTypeUri}?shipping_type=$type');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> setCategoryWiseShippingCost(List<int? >  ids, List<double> cost, List<int> multiPly) async {
    try {
      final response = await dioClient!.post(AppConstants.setCategoryWiseShippingCost,
          data: {'ids' : ids, 'cost' : cost, 'multiply_qty' : multiPly});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<ApiResponse> shippingOnOff(int? id,int status) async {
    try {
      final response = await dioClient!.post(AppConstants.shippingMethodOnOff,
          data: {
        '_method': 'put',
            'id' : id,
            'status' : status
      });
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


}