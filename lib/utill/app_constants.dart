

import 'package:sixvalley_vendor_app/data/model/response/language_model.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';

class AppConstants {
  static const String appName = 'Seller App';
  static const String appVersion = '14.0';
  static const String companyName = '6Valley';
  static const String baseUrl = 'https://6valley.6amtech.com';
  static const String loginUri = '/api/v3/seller/auth/login';
  static const String configUri = '/api/v1/config';
  static const String sellerUri = '/api/v3/seller/seller-info';
  static const String sellerAndBankUpdate = '/api/v3/seller/seller-update';
  static const String shopUri = '/api/v3/seller/shop-info';
  static const String shopUpdate = '/api/v3/seller/shop-update';
  static const String cartUri = '/api/v3/seller/messages/list/';
  static const String chatSearchUri = '/api/v3/seller/messages/search/';
  static const String messageUri = '/api/v3/seller/messages/get-message/';
  static const String sendMessageUri = '/api/v3/seller/messages/send/';
  static const String orderListUri = '/api/v3/seller/orders/list';
  static const String orderDetails = '/api/v3/seller/orders/';
  static const String updateOrderStatus = '/api/v3/seller/orders/order-detail-status/';
  static const String balanceWithdraw = '/api/v3/seller/balance-withdraw';
  static const String cancelBalanceRequest = '/api/v3/seller/close-withdraw-request';
  static const String transactionUri = '/api/v3/seller/transactions?status=';
  static const String sellerProductUri = '/api/v1/seller/';
  static const String stockOutProductUri = '/api/v3/seller/products/stock-out-list?limit=10&offset=';
  static const String productReviewUri = '/api/v3/seller/shop-product-reviews';
  static const String productReviewStatusOnOff = '/api/v3/seller/shop-product-reviews-status';
  static const String attributeUri = '/api/v1/attributes';
  static const String brandUri = '/api/v3/seller/brands';
  static const String categoryUri = '/api/v1/categories/';
  static const String subCategoryUri = '/api/v1/categories/childes/';
  static const String subSubCategoryUri = '/api/v1/categories/childes/childes/';
  static const String addProductUri = '/api/v3/seller/products/add';
  static const String uploadProductImageUri = '/api/v3/seller/products/upload-images';
  static const String updateProductUri = '/api/v3/seller/products/update';
  static const String deleteProductUri = '/api/v3/seller/products/delete';
  static const String editProductUri = '/api/v3/seller/products/edit';
  static const String addShippingUri = '/api/v3/seller/shipping-method/add';
  static const String updateShippingUri = '/api/v3/seller/shipping-method/update';
  static const String editShippingUri = '/api/v3/seller/shipping-method/edit';
  static const String deleteShippingUri = '/api/v3/seller/shipping-method/delete';
  static const String getShippingUri = '/api/v3/seller/shipping-method/list';
  static const String getDeliveryManUri = '/api/v3/seller/seller-delivery-man';
  static const String assignDeliveryManUri = '/api/v3/seller/orders/assign-delivery-man';
  static const String tokenUri = '/api/v3/seller/cm-firebase-token';
  static const String refundListUri = '/api/v3/seller/refund/list';
  static const String refundItemDetails = '/api/v3/seller/refund/refund-details';
  static const String refundReqStatusUpdate = '/api/v3/seller/refund/refund-status-update';
  static const String showShippingCostUri = '/api/v3/seller/shipping/all-category-cost';
  static const String setCategoryWiseShippingCost = '/api/v3/seller/shipping/set-category-cost';
  static const String setShippingMethodTypeUri = '/api/v3/seller/shipping/selected-shipping-method';
  static const String getShippingMethodTypeUri = '/api/v3/seller/shipping/get-shipping-method';
  static const String thirdPartyDeliveryManAssign = '/api/v3/seller/orders/assign-third-party-delivery';
  static const String forgetPasswordUri = '/api/v3/seller/auth/forgot-password';
  static const String verifyOtpUri = '/api/v3/seller/auth/verify-otp';
  static const String resetPasswordUri = '/api/v3/seller/auth/reset-password';
  static const String paymentStatusUpdate = '/api/v3/seller/orders/update-payment-status';
  static const String barCodeGenerateUri = '/api/v3/seller/products/barcode/generate';
  static const String digitalProductUpload = '/api/v3/seller/products/upload-digital-product';
  static const String digitalProductUploadAfterSell = '/api/v3/seller/orders/order-wise-product-upload';
  static const String registration = '/api/v3/seller/registration';
  static const String deleteAccount = '/api/v3/seller/account-delete';
  static const String deliveryChargeForDelivery = '/api/v3/seller/orders/delivery-charge-date-update';

  static const String getCouponDiscount = '/api/v3/seller/coupon/check-coupon';
  static const String placeOrderUri = '/api/v3/seller/pos/place-order';
  static const String getProductFromProductCode = '/api/v3/seller/pos/products';
  static const String customerSearchUri = '/api/v3/seller/pos/customers';
  static const String getCustomerListUri = '/api/v3/seller/pos/customers?';
  static const String invoice = '/api/v3/seller/pos/get-invoice';
  static const String topSellingProduct = '/api/v3/seller/products/top-selling-product?limit=10&offset=';
  static const String mostPopularProduct = '/api/v3/seller/products/most-popular-product?limit=10&offset=';
  static const String topDeliveryMan = '/api/v3/seller/top-delivery-man';
  static const String deliveryManListUri = '/api/v3/seller/delivery-man/list';
  static const String deliveryManDetails = '/api/v3/seller/delivery-man/details/';
  static const String posProductList = '/api/v3/seller/pos/product-list';
  static const String searchPosProductList = '/api/v3/seller/pos/product-list';
  static const String shippingMethodOnOff = '/api/v3/seller/shipping-method/status';
  static const String updateProductQuantity = '/api/v3/seller/products/quantity-update';
  static const String productWiseReviewList = '/api/v3/seller/products/review-list/';
  static const String addDeliveryMan = '/api/v3/seller/delivery-man/store';
  static const String updateDeliveryMan = '/api/v3/seller/delivery-man/update';
  static const String deleteDeliveryman = '/api/v3/seller/delivery-man/delete/';
  static const String deliveryManOrderHistory = '/api/v3/seller/delivery-man/order-list/';
  static const String deliveryManEarning = '/api/v3/seller/delivery-man/earning/';
  static const String collectCashFromDeliveryMan = '/api/v3/seller/delivery-man/cash-receive';
  static const String emergencyContactAdd = '/api/v3/seller/delivery-man/emergency-contact/store';
  static const String emergencyContactUpdate = '/api/v3/seller/delivery-man/emergency-contact/update';
  static const String getEmergencyContactList = '/api/v3/seller/delivery-man/emergency-contact/list';
  static const String emergencyContactStatusOnOff = '/api/v3/seller/delivery-man/emergency-contact/status-update';
  static const String emergencyContactDelete = '/api/v3/seller/delivery-man/emergency-contact/delete';
  static const String deliveryManWithdrawList = '/api/v3/seller/delivery-man/withdraw/list';
  static const String deliveryManReviewList = '/api/v3/seller/delivery-man/reviews/';
  static const String deliveryManWithdrawDetails = '/api/v3/seller/delivery-man/withdraw/details/';
  static const String deliveryManWithdrawApprovedRejected = '/api/v3/seller/delivery-man/withdraw/status-update';
  static const String addNewCustomer = '/api/v3/seller/pos/customer-store';
  static const String productStatusOnOff = '/api/v3/seller/products/status-update';
  static const String deliveryManStatusOnOff = '/api/v3/seller/delivery-man/status-update';
  static const String earningStatistics = '/api/v3/seller/get-earning-statitics?type=';
  static const String businessAnalytics = '/api/v3/seller/order-statistics?statistics_type=';
  static const String productDetails = '/api/v3/seller/products/details/';
  static const String deliveryManOrderChangeLog = '/api/v3/seller/delivery-man/order-status-history/';
  static const String chartFilterData = '/api/v3/seller/get-earning-statitics?type=';
  static const String addNewCoupon = '/api/v3/seller/coupon/store';
  static const String getCouponList = '/api/v3/seller/coupon/list';
  static const String updateCoupon = '/api/v3/seller/coupon/update/';
  static const String deleteCoupon = '/api/v3/seller/coupon/delete/';
  static const String couponStatusUpdate = '/api/v3/seller/coupon/status-update/';
  static const String deliveryManCollectedCashList = '/api/v3/seller/delivery-man/collect-cash-list/';
  static const String couponCustomerList = '/api/v3/seller/coupon/customers?name=';
  static const String temporaryClose = '/api/v3/seller/temporary-close';
  static const String vacation = '/api/v3/seller/vacation-add';
  static const String dynamicWithdrawMethod = '/api/v3/seller/withdraw-method-list';






  static const String pending = 'pending';
  static const String confirmed = 'confirmed';
  static const String processing = 'processing';
  static const String processed = 'processed';
  static const String delivered = 'delivered';
  static const String failed = 'failed';
  static const String returned = 'returned';
  static const String cancelled = 'canceled';
  static const String outForDelivery = 'out_for_delivery';
  static const String approved = 'approved';
  static const String rejected = 'rejected';
  static const String done = 'refunded';



  static const String orderWise = 'order_wise';
  static const String productWise = 'product_wise';
  static const String categoryWise = 'category_wise';



  static const String theme = 'theme';
  static const String currency = 'currency';
  static const String shippingType = 'shipping_type';
  static const String token = 'token';
  static const String countryCode = 'country_code';
  static const String languageCode = 'language_code';
  static const String cartList = 'cart_list';
  static const String userAddress = 'user_address';
  static const String userPassword = 'user_password';
  static const String userNumber = 'user_number';
  static const String searchAddress = 'search_address';
  static const String topic = 'six_valley_seller';
  static const String userEmail = 'user_email';
  static const String langKey = 'lang';

  static List<LanguageModel> languages = [
    LanguageModel(imageUrl: Images.unitedKingdom, languageName: 'English', countryCode: 'US', languageCode: 'en'),
    LanguageModel(imageUrl: Images.arabic, languageName: 'Arabic', countryCode: 'SA', languageCode: 'ar'),
  ];
}
