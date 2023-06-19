import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/data/model/response/order_model.dart';
import 'package:sixvalley_vendor_app/helper/price_converter.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/main.dart';
import 'package:sixvalley_vendor_app/provider/delivery_man_provider.dart';
import 'package:sixvalley_vendor_app/provider/order_provider.dart';
import 'package:sixvalley_vendor_app/provider/splash_provider.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/base/custom_app_bar.dart';
import 'package:sixvalley_vendor_app/view/base/custom_button.dart';
import 'package:sixvalley_vendor_app/view/base/custom_divider.dart';
import 'package:sixvalley_vendor_app/view/base/no_data_screen.dart';
import 'package:sixvalley_vendor_app/view/screens/order/widget/customer_contact_widget.dart';
import 'package:sixvalley_vendor_app/view/screens/order/widget/delivery_man_information.dart';
import 'package:sixvalley_vendor_app/view/screens/order/widget/order_product_list_item.dart';
import 'package:sixvalley_vendor_app/view/screens/order/widget/order_setup.dart';
import 'package:sixvalley_vendor_app/view/screens/order/widget/order_top_section.dart';
import 'package:sixvalley_vendor_app/view/screens/order/widget/shipping_and_biilling_widget.dart';
import 'package:sixvalley_vendor_app/view/screens/order/widget/third_party_delivery_info.dart';


class OrderDetailsScreen extends StatefulWidget {
  final Order? orderModel;
  final int? orderId;
  final String? orderType;
  final String? shippingType;
  final double? extraDiscount;
  final String? extraDiscountType;
  const OrderDetailsScreen({Key? key, this.orderModel, required this.orderId, required this.orderType, this.shippingType, this.extraDiscount, this.extraDiscountType}) : super(key: key);

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  void _loadData(BuildContext context, String? type) async {
    if(widget.orderModel == null) {
      await Provider.of<SplashProvider>(Get.context!, listen: false).initConfig();
    }
    Provider.of<OrderProvider>(Get.context!, listen: false).getOrderDetails(widget.orderId.toString());
    Provider.of<OrderProvider>(Get.context!, listen: false).initOrderStatusList(
        Provider.of<SplashProvider>(Get.context!, listen: false).configModel!.shippingMethod == 'inhouse_shipping' ?  'inhouse_shipping':"seller_wise");
    Provider.of<DeliveryManProvider>(Get.context!, listen: false).getDeliveryManList(widget.orderModel);
  }


  bool _onlyDigital = true;

  @override
  void initState() {

    Provider.of<OrderProvider>(context, listen: false).setPaymentStatus(widget.orderModel!.paymentStatus);
    Provider.of<OrderProvider>(context, listen: false).updateStatus(widget.orderModel!.orderStatus, notify: false);
    super.initState();
  }

  @override
  Widget build(BuildContext c) {
    _loadData(context,widget.shippingType);
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(title: getTranslated('order_details', context)),

      body: RefreshIndicator(
        onRefresh: () async{
          _loadData(context,widget.shippingType);
        },
        child: Consumer<OrderProvider>(
            builder: (context, order, child) {


              double itemsPrice = 0;
              double discount = 0;
              double? eeDiscount = 0;
              double coupon = widget.orderModel!.discountAmount!;
              double tax = 0;
              double shipping = widget.orderModel!.shippingCost!;
              if (order.orderDetails != null) {
                for (var orderDetails in order.orderDetails!) {
                  if(orderDetails.productDetails?.productType == "physical"){
                    _onlyDigital =  false;
                  }
                  itemsPrice = itemsPrice + (orderDetails.price! * orderDetails.qty!);
                  discount = discount + orderDetails.discount!;

                    tax = tax + orderDetails.tax!;

                }
              }
              double subTotal = itemsPrice +tax - discount;

              if(widget.orderType == 'POS'){
                if(widget.extraDiscountType == 'percent'){
                  eeDiscount = itemsPrice * (widget.extraDiscount!/100);
                }else{
                  eeDiscount = widget.extraDiscount;
                }
              }
              double totalPrice = subTotal + shipping - coupon - eeDiscount!;

              return order.orderDetails != null ? order.orderDetails!.isNotEmpty ?
              ListView(
                physics: const BouncingScrollPhysics(),
                children: [

                  OrderTopSection(orderModel: widget.orderModel, order: order, orderType: widget.orderType, onlyDigital: _onlyDigital,),

                  const SizedBox(height: Dimensions.paddingSizeExtraSmall),


                  widget.orderType == 'POS'? const SizedBox():
                  ShippingAndBillingWidget(orderModel: widget.orderModel, onlyDigital: _onlyDigital),



                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                    Container(
                      padding: const EdgeInsets.fromLTRB( Dimensions.paddingSizeDefault,
                          Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault,0),

                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(getTranslated('order_summery', context)!,
                            style: titilliumSemiBold.copyWith(fontSize: Dimensions.fontSizeLarge,
                              color: ColorResources.titleColor(context),) ),
                        const SizedBox(height: Dimensions.paddingSizeDefault,),


                        ListView.builder(
                          padding: const EdgeInsets.all(0),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: order.orderDetails!.length,
                          itemBuilder: (context, index) {
                            return OrderedProductListItem(orderDetailsModel: order.orderDetails![index],
                                paymentStatus: order.paymentStatus,orderId: widget.orderId,
                              index: index, length: order.orderDetails!.length,
                            );
                          },
                        ),

                      ],
                    ),),


                    widget.orderModel!.orderNote != null?
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                          boxShadow: [BoxShadow(color: Theme.of(context).hintColor.withOpacity(.25),spreadRadius: .11,blurRadius: .11, offset: const Offset(0,2))],
                        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(Dimensions.paddingSizeSmall),
                            bottomRight: Radius.circular(Dimensions.paddingSizeSmall)),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).hintColor.withOpacity(.07),
                          borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(Dimensions.paddingSizeSmall),
                              bottomRight: Radius.circular(Dimensions.paddingSizeSmall)),

                        ),
                        padding: const EdgeInsets.fromLTRB( Dimensions.paddingSizeDefault,Dimensions.paddingSizeDefault,Dimensions.paddingSizeDefault,
                             Dimensions.paddingSizeDefault),

                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: Dimensions.paddingSizeSmall),
                                child: Image.asset(Images.orderNote,color: ColorResources.getTextColor(context), width: Dimensions.iconSizeSmall ),
                              ),
                              Text(getTranslated('order_note', context)!, style: titilliumSemiBold.copyWith(fontSize: Dimensions.fontSizeLarge,
                                color: ColorResources.titleColor(context),)),
                            ],
                          ),
                          const SizedBox(height: Dimensions.paddingSizeExtraSmall),

                          Text(widget.orderModel!.orderNote != null? widget.orderModel!.orderNote ?? '': "",
                              style: titilliumRegular.copyWith(color: ColorResources.getTextColor(context))),
                        ],),
                      ),
                    ):const SizedBox(),



                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault,
                          vertical: Dimensions.paddingSizeDefault),
                      child: Column(children: [

                      // Total
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        Text(getTranslated('sub_total', context)!,
                            style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeLarge,
                                color: ColorResources.titleColor(context))),


                        Text(PriceConverter.convertPrice(context, itemsPrice),
                            style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeLarge,
                                color: ColorResources.titleColor(context))),]),
                      const SizedBox(height: Dimensions.paddingSizeSmall,),



                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        Text(getTranslated('tax', context)!,
                            style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeLarge,
                                color: ColorResources.titleColor(context))),


                        Text('+ ${PriceConverter.convertPrice(context, tax)}',
                            style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeLarge,
                                color: ColorResources.titleColor(context))),]),
                      const SizedBox(height: Dimensions.paddingSizeSmall,),




                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        Text(getTranslated('discount', context)!,
                            style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeLarge,
                                color: ColorResources.titleColor(context))),


                        Text('- ${PriceConverter.convertPrice(context, discount)}',
                            style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeLarge,
                                color: ColorResources.titleColor(context))),]),
                      const SizedBox(height: Dimensions.paddingSizeSmall,),



                      widget.orderType == "POS"?
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        Text(getTranslated('extra_discount', context)!,
                            style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeLarge,
                                color: ColorResources.titleColor(context))),
                        Text('- ${PriceConverter.convertPrice(context, eeDiscount)}',
                            style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeLarge,
                                color: ColorResources.titleColor(context))),
                      ]):const SizedBox(),
                      SizedBox(height:  widget.orderType == "POS"? Dimensions.paddingSizeSmall: 0),


                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        Text(getTranslated('coupon_discount', context)!,
                            style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeLarge,
                                color: ColorResources.titleColor(context))),
                        Text('- ${PriceConverter.convertPrice(context, coupon)}',
                            style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeLarge,
                                color: ColorResources.titleColor(context))),]),
                      const SizedBox(height: Dimensions.paddingSizeSmall,),



                      if(!_onlyDigital)Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        Text(getTranslated('shipping_fee', context)!,
                            style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeLarge,
                                color: ColorResources.titleColor(context))),
                        Text('+ ${PriceConverter.convertPrice(context, shipping)}',
                            style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeLarge,
                                color: ColorResources.titleColor(context))),]),

                        const SizedBox(height: Dimensions.paddingSizeSmall),
                        const CustomDivider(),
                        const SizedBox(height: Dimensions.paddingSizeSmall),



                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Text(getTranslated('total_amount', context)!,
                              style: titilliumSemiBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge,
                                  color: Theme.of(context).primaryColor)),
                          Text(PriceConverter.convertPrice(context, totalPrice),
                            style: titilliumSemiBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge,
                                color: Theme.of(context).primaryColor),),]),
                    ],),),




                  ]),




                  widget.orderModel!.customer != null?
                  CustomerContactWidget(orderModel: widget.orderModel):const SizedBox(),

                  const SizedBox(height: Dimensions.paddingSizeExtraSmall),


                  widget.orderModel!.deliveryMan != null?
                  Padding(
                    padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
                    child: DeliveryManContactInformation(orderModel: widget.orderModel, orderType: widget.orderType, onlyDigital: _onlyDigital),
                  ):const SizedBox(),

                  widget.orderModel!.thirdPartyServiceName != null?
                  Padding(
                    padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
                    child: ThirdPartyDeliveryInfo(orderModel: widget.orderModel),
                  ):const SizedBox.shrink(),

                ],
              ) : const NoDataScreen() : Center(child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)));
            }
        ),
      ),

      bottomNavigationBar: widget.orderType =='POS'? const SizedBox.shrink():Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          boxShadow: ThemeShadow.getShadow(context)
        ),

          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeSmall),
          child: CustomButton(
              borderRadius: Dimensions.paddingSizeMedium,
              btnTxt: getTranslated('order_setup', context),
            onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (_) =>
                    OrderSetup(orderType: widget.orderType, orderModel: widget.orderModel, onlyDigital: _onlyDigital)));
            },
          )),
    );
  }
}
