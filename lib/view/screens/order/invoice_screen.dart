import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/helper/date_converter.dart';
import 'package:sixvalley_vendor_app/helper/price_converter.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/main.dart';
import 'package:sixvalley_vendor_app/provider/order_provider.dart';
import 'package:sixvalley_vendor_app/provider/shop_info_provider.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/base/custom_app_bar.dart';
import 'package:sixvalley_vendor_app/view/base/custom_divider.dart';
import 'package:sixvalley_vendor_app/view/screens/pos_printer/invoice_print.dart';
import 'widget/invoice_element_view.dart';

class InVoiceScreen extends StatefulWidget {
  final int? orderId;
  const InVoiceScreen({Key? key, this.orderId}) : super(key: key);

  @override
  State<InVoiceScreen> createState() => _InVoiceScreenState();
}

class _InVoiceScreenState extends State<InVoiceScreen> {
  Future<void> _loadData() async {
    await Provider.of<OrderProvider>(Get.context!, listen: false).getInvoiceData(widget.orderId);
    Provider.of<ShopProvider>(Get.context!, listen: false).getShopInfo();
  }
  double totalPayableAmount = 0;
  double couponDiscount = 0;
  @override
  void initState() {
    _loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: getTranslated('invoice', context),),

      body: Consumer<ShopProvider>(
        builder: (context, shopController, _) {

          return SingleChildScrollView(
            child: Consumer<OrderProvider>(
              builder: (context, invoiceProvider, _) {
                if(invoiceProvider.invoice != null &&  invoiceProvider.invoice!.orderAmount != null){
                  totalPayableAmount = invoiceProvider.invoice!.orderAmount! +
                      invoiceProvider.totalTaxAmount - invoiceProvider.discountOnProduct - invoiceProvider.invoice!.extraDiscount! - invoiceProvider.invoice!.discountAmount!;
                }
                return Column(children: [


                  Padding(
                    padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                    child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      const Expanded(flex: 3,child: SizedBox.shrink()),
                      Padding(
                        padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                        child: Container(width: 80,
                          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeSmall),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                            color: Theme.of(context).primaryColor,

                          ),
                          child: InkWell(
                            onTap: (){
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) => InVoicePrintScreen(shopModel: shopController.shopModel,
                                    invoice : invoiceProvider.invoice,
                                    orderId: widget.orderId,
                                    discountProduct: invoiceProvider.discountOnProduct,
                                    total: totalPayableAmount,
                                  )));

                            },
                            child: Center(child: Row(
                              children: [
                                Icon(Icons.event_note_outlined, color: Theme.of(context).cardColor, size: 15,),
                                const SizedBox(width: Dimensions.paddingSizeSmall),
                                Text(getTranslated('print', context)!, style: robotoRegular.copyWith(color: Theme.of(context).cardColor),),
                              ],
                            )),
                          ),),
                      ),

                    ],),
                  ),

                  Column(crossAxisAlignment: CrossAxisAlignment.center, children: [

                    Text(shopController.shopModel?.name??'',
                      style: robotoBold.copyWith(
                        fontSize: Dimensions.fontSizeExtraLargeTwenty),),
                    const SizedBox(height: Dimensions.paddingSizeSmall),



                    Text('${getTranslated('phone', context)} : ${shopController.shopModel?.contact??''}',
                      style: robotoRegular.copyWith(),),
                    const SizedBox(height: Dimensions.paddingSizeExtraSmall),


                  ],),


                  Consumer<OrderProvider>(
                    builder: (context, orderController, _) {
                      return orderController.invoice != null && orderController.invoice!.details != null &&  orderController.invoice!.details!.isNotEmpty ?
                        Padding(
                        padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                        child: Column(children: [
                          CustomDivider(color: Theme.of(context).hintColor),
                          const SizedBox(height: Dimensions.paddingSizeDefault),

                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                            Text('${getTranslated('invoice', context)!.toUpperCase()} # ${widget.orderId}',
                                style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge)),

                            Text(getTranslated('payment_method', context)!,
                                style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge)),
                          ],),
                          const SizedBox(height: Dimensions.paddingSizeSmall),

                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                            Text(DateConverter.dateTimeStringToMonthAndTime(orderController.invoice!.createdAt!),
                                style: robotoRegular),

                              Text('${getTranslated('paid_by', context)} ${getTranslated(invoiceProvider.invoice!.paymentMethod??'cash', context)}',
                                  style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeDefault,
                            )),
                          ],),
                          const SizedBox(height: Dimensions.paddingSizeDefault),

                          CustomDivider(color: Theme.of(context).hintColor),
                          const SizedBox(height: Dimensions.paddingSizeLarge),


                          InvoiceElementView(serial: getTranslated('sl', context),
                              title: getTranslated('product_info', context),
                              quantity: getTranslated('qty', context),
                              price: getTranslated('price', context), isBold: true),
                          const SizedBox(height: Dimensions.paddingSizeDefault),
                          ListView.builder(
                            itemBuilder: (con, index){

                              return SizedBox(height: 50,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(children: [
                                    Expanded(flex: 5,
                                      child:  Row(mainAxisAlignment: MainAxisAlignment.start,children: [
                                        Text((index+1).toString()),
                                        const SizedBox(width: Dimensions.paddingSizeDefault),

                                        orderController.invoice!.details![index].variant != null?
                                        Expanded(
                                            child: Text('${orderController.invoice!.details![index].productDetails!.name} (${orderController.invoice!.details![index].variant??''})',
                                              maxLines: 2,overflow: TextOverflow.ellipsis,)):
                                        Expanded(
                                            child: Text('${orderController.invoice!.details![index].productDetails!.name}',
                                              maxLines: 2,overflow: TextOverflow.ellipsis,))

                                      ],)
                                    ),
                                    const SizedBox(width: Dimensions.paddingSizeExtraSmall),

                                    Expanded(flex: 3,
                                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                        Text(orderController.invoice!.details![index].qty.toString()),
                                        const SizedBox(width: Dimensions.paddingSizeDefault),

                                        Text(PriceConverter.convertPrice(context, orderController.invoice!.details![index].price)),
                                      ],),
                                    ),
                                  ],)
                                ),
                              );
                            },
                            itemCount: orderController.invoice!.details!.length,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                            child: CustomDivider(color: Theme.of(context).hintColor),
                          ),


                          Column(children: [

                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                              Text(getTranslated('subtotal', context)!,style: robotoRegular.copyWith(),),
                              Text(PriceConverter.convertPrice(context, orderController.invoice!.orderAmount)),
                            ],),
                            const SizedBox(height: Dimensions.paddingSizeSmall),


                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                              Text(getTranslated('product_discount', context)!,style: robotoRegular.copyWith(),),
                              Text('- ${PriceConverter.convertPrice(context, invoiceProvider.discountOnProduct)}'),
                            ],),
                            const SizedBox(height: Dimensions.paddingSizeSmall),


                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                              Text(getTranslated('coupon_discount', context)!,style: robotoRegular.copyWith(),),
                              Text('- ${PriceConverter.convertPrice(context, orderController.invoice!.discountAmount)}'),
                            ],),
                            const SizedBox(height: Dimensions.paddingSizeSmall),


                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                              Text(getTranslated('extra_discount', context)!,style: robotoRegular.copyWith(),),
                              Text(' - ${PriceConverter.convertPrice(context, orderController.invoice!.extraDiscount)}'),
                            ],),
                            const SizedBox(height: Dimensions.paddingSizeSmall),


                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                              Text(getTranslated('tax', context)!,style: robotoRegular.copyWith(),),
                              Text(' + ${PriceConverter.convertPrice(context, invoiceProvider.totalTaxAmount)}'),
                            ],),
                            const SizedBox(height: Dimensions.paddingSizeSmall),
                          ],),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
                            child: CustomDivider(color: Theme.of(context).hintColor),
                          ),

                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                            Text(getTranslated('total', context)!,style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge),),
                            Text(PriceConverter.convertPrice(context, totalPayableAmount),
                                style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge)),
                          ],),
                          const SizedBox(height: Dimensions.paddingSizeDefault),





                          Text('"""${getTranslated('thank_you', context)}"""', style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeExtraLarge)),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeLarge),
                            child: CustomDivider(color: Theme.of(context).hintColor),
                          ),



                        ],),
                      ):const SizedBox();
                    }
                  ),







                ],);
              }
            ),
          );
        }
      ),
    );
  }
}
