
import 'package:http_parser/http_parser.dart';
import 'package:sixvalley_vendor_app/data/datasource/remote/dio/dio_client.dart';
import 'package:sixvalley_vendor_app/data/datasource/remote/exception/api_error_handler.dart';
import 'package:sixvalley_vendor_app/data/model/body/delivery_man_body.dart';
import 'package:sixvalley_vendor_app/data/model/response/base/api_response.dart';
import 'package:sixvalley_vendor_app/utill/app_constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;

class DeliveryManRepo {
  final DioClient? dioClient;
  DeliveryManRepo({required this.dioClient});

  Future<ApiResponse> getDeliveryManList() async {
    try {
      final response = await dioClient!.get(AppConstants.getDeliveryManUri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<ApiResponse> deliveryManWithdrawList(int offset, String status) async {
    try {
      final response = await dioClient!.get('${AppConstants.deliveryManWithdrawList}?limit=10&offset=$offset&status=$status');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<ApiResponse> getDeliveryManReviewList(int offset, int? id) async {
    try {
      final response = await dioClient!.get('${AppConstants.deliveryManReviewList}$id?limit=10&offset=$offset');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> deliveryManWithdrawDetails(int? id) async {
    try {
      final response = await dioClient!.get('${AppConstants.deliveryManWithdrawDetails}$id');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> deliveryManWithdrawApprovedDenied(int? id, String note, int approved) async {
    try {
      final response = await dioClient!.post(AppConstants.deliveryManWithdrawApprovedRejected,
          data: {
            '_method':"put",
            'id':id,
            'note':note,
            'approved':approved
          });
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }



  Future<ApiResponse> deliveryManList(int offset, String search) async {
    try {
      final response = await dioClient!.get('${AppConstants.deliveryManListUri}?limit=10&offset=$offset&search=$search');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  Future<ApiResponse> deliveryManDetails(int? deliveryManId) async {
    try {
      final response = await dioClient!.get('${AppConstants.deliveryManDetails}$deliveryManId');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<ApiResponse> deliveryManOrderList(int offset, int? deliverymanId) async {
    try {
      final response = await dioClient!.get('${AppConstants.deliveryManOrderHistory}$deliverymanId?limit=10&offset=$offset');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<ApiResponse> deliveryManEarningList(int offset, int? deliverymanId) async {
    try {
      final response = await dioClient!.get('${AppConstants.deliveryManEarning}$deliverymanId?limit=10&offset=$offset');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getTopDeliveryManList() async {
    try {
      final response = await dioClient!.get(AppConstants.topDeliveryMan);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> assignDeliveryMan(int? orderId, int? deliveryManId) async {
    try {
      final response = await dioClient!.post(AppConstants.assignDeliveryManUri, data: {'_method': 'put','order_id' : orderId, 'delivery_man_id' : deliveryManId});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<ApiResponse> deliveryManStatusOnOff(int? id, int status) async {
    try {
      final response = await dioClient!.post(AppConstants.deliveryManStatusOnOff,
          data: {
            'id' : id,
            'status' : status
      });
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> collectCashFromDeliveryMan(int? deliveryManId, String amount) async {
    try {
      if (kDebugMode) {
        print('====>id==$deliveryManId== and amount ===$amount');
      }
      final response = await dioClient!.post(AppConstants.collectCashFromDeliveryMan,
          data: {'deliveryman_id' : deliveryManId, 'amount': amount});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> deleteDeliveryMan(int? deliveryManId) async {
    try {
      final response = await dioClient!.get('${AppConstants.deleteDeliveryman}$deliveryManId');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getDeliverymanOrderHistoryLog(int? orderId) async {
    try {
      final response = await dioClient!.get('${AppConstants.deliveryManOrderChangeLog}$orderId');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> addNewDeliveryMan(XFile? profileImage, List<XFile?> identityImage, DeliveryManBody deliveryManBody,String token,{bool isUpdate = false}) async {
    http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse(
        isUpdate?
        '${AppConstants.baseUrl}${AppConstants.updateDeliveryMan}/${deliveryManBody.id}':
        '${AppConstants.baseUrl}${AppConstants.addDeliveryMan}'
    )
    );
    request.headers.addAll(<String,String>{'Authorization': 'Bearer $token'});
    if(profileImage != null) {
      Uint8List list = await profileImage.readAsBytes();
      var part = http.MultipartFile('image', profileImage.readAsBytes().asStream(), list.length, filename: basename(profileImage.path));
      request.files.add(part);
    } if(identityImage.isNotEmpty) {
      if (kDebugMode) {
        print('========Identity image========>${identityImage.length}');
      }


     for(int i = 0; i< identityImage.length; i++){
       Uint8List list = await identityImage[i]!.readAsBytes();
       var part = http.MultipartFile(
           'identity_image[]', identityImage[i]!.readAsBytes().asStream(),
           list.length,
           filename: basename(identityImage[i]!.path),
       );
       request.files.add(part);
     }

    }

    Map<String, String> fields = {};
    fields.addAll(<String, String>{
      'f_name': deliveryManBody.fName!,
      'l_name': deliveryManBody.lName!,
      'address': deliveryManBody.address!,
      'phone': deliveryManBody.phone!,
      'email': deliveryManBody.email!,
      'country_code' : deliveryManBody.countryCode!,
      'identity_number' : deliveryManBody.identityNumber!,
      'identity_type' : deliveryManBody.identityType!,
      'password': deliveryManBody.password!,
      'confirm_password': deliveryManBody.confirmPassword!,
      '_method': isUpdate? 'put': 'post'

    });

    request.fields.addAll(fields);
    if (kDebugMode) {
      print('=====> ${request.url.path}\n${request.fields}');
    }

    http.StreamedResponse response = await request.send();
    var res = await http.Response.fromStream(response);
    if (kDebugMode) {
      print('=====Response body is here==>${res.body}');
    }

    try {
      return ApiResponse.withSuccess(Response(statusCode: response.statusCode,
          requestOptions: RequestOptions(path: ''), statusMessage: response.reasonPhrase, data: res.body));
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getDeliveryManCollectedCashList(int? id, int offset) async {
    try {
      final response = await dioClient!.get('${AppConstants.deliveryManCollectedCashList}$id?limit=10&offset=$offset');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}