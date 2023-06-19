import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/data/model/response/order_model.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/delivery_man_provider.dart';
import 'package:sixvalley_vendor_app/provider/order_provider.dart';
import 'package:sixvalley_vendor_app/provider/splash_provider.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/base/custom_button.dart';
import 'package:sixvalley_vendor_app/view/base/custom_snackbar.dart';
import 'package:sixvalley_vendor_app/view/base/textfeild/custom_text_feild.dart';

class DeliveryManAssignWidget extends StatefulWidget {
  final int? orderId;
  final String? orderType;
  final Order? orderModel;
  const DeliveryManAssignWidget({Key? key, this.orderType, this.orderModel, this.orderId}) : super(key: key);

  @override
  State<DeliveryManAssignWidget> createState() => _DeliveryManAssignWidgetState();
}

class _DeliveryManAssignWidgetState extends State<DeliveryManAssignWidget> {


  final TextEditingController _thirdPartyShippingNameController = TextEditingController();
  final TextEditingController _thirdPartyShippingIdController = TextEditingController();
  final FocusNode _thirdPartyShippingNameNode = FocusNode();
  final FocusNode _thirdPartyShippingIdNode = FocusNode();
  String deliveryType = 'select delivery type';
  final TextEditingController _deliveryManCharge = TextEditingController();
  final TextEditingController _expectedDeliveryDate = TextEditingController();

  @override
  void initState() {

    if(widget.orderModel!.deliverymanCharge != null){
      _deliveryManCharge.text = widget.orderModel!.deliverymanCharge.toString();
    }
    if(widget.orderModel!.expectedDeliveryDate != null){
      _expectedDeliveryDate.text = widget.orderModel!.expectedDeliveryDate!;
    }

    if(widget.orderModel!.thirdPartyServiceName!=null){
      _thirdPartyShippingNameController.text = widget.orderModel!.thirdPartyServiceName!;
    }
    if(widget.orderModel!.thirdPartyTrackingId!=null){
      _thirdPartyShippingIdController.text = widget.orderModel!.thirdPartyTrackingId!;
    }
    if(widget.orderModel!.deliveryType != null){
      if(widget.orderModel!.deliveryType == 'self_delivery'){
        Provider.of<DeliveryManProvider>(context, listen: false).setDeliveryTypeIndex(1, false);
      }else{
        Provider.of<DeliveryManProvider>(context, listen: false).setDeliveryTypeIndex(2, false);
      }

    }

    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Consumer<DeliveryManProvider>(
      builder: (context, delivery, _) {
        return Column(children: [
          Provider.of<SplashProvider>(context,listen: false).configModel!.shippingMethod =='sellerwise_shipping' && widget.orderType != 'POS'?
          Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(getTranslated('delivery_type', context)!, style: robotoRegular,),
              const SizedBox(height: Dimensions.paddingSizeSmall,),
              SizedBox(height: 45,
                child: Container( padding: const EdgeInsets.symmetric(horizontal:Dimensions.fontSizeExtraSmall ),
                    decoration: BoxDecoration(color: Theme.of(context).highlightColor,
                        border: Border.all(width: .5,color: Theme.of(context).hintColor.withOpacity(.5)),
                        borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall)),
                    child: DropdownButton<String>(
                      value: delivery.selectedDeliveryTypeIndex ==0? 'select_delivery_type':delivery.selectedDeliveryTypeIndex ==1? 'by_self_delivery_man':'by_third_party_delivery_service',
                      isExpanded: true,
                      underline: const SizedBox(),
                      onChanged: (String? newValue) {
                       delivery.setDeliveryTypeIndex(newValue == 'select_delivery_type'? 0 : newValue == 'by_self_delivery_man'? 1 : 2, true);
                      },
                      items:delivery.deliveryTypeList.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(getTranslated(value, context)!),
                        );
                      }).toList(),
                    )
                ),
              ),
              const SizedBox(height: Dimensions.paddingSizeDefault),





              delivery.selectedDeliveryTypeIndex == 1?
              Padding(padding: const EdgeInsets.only(bottom: 20.0),
                child: widget.orderType == 'POS'? const SizedBox(): Consumer<DeliveryManProvider>(builder: (context, deliveryMan, child) {
                  return Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(getTranslated('deliveryman', context)!, style: robotoRegular,),
                      const SizedBox(height: Dimensions.paddingSizeSmall,),
                      Row(children: [Expanded(child: Container(
                        padding: const EdgeInsets.only(left: Dimensions.paddingSizeSmall, right: Dimensions.paddingSizeSmall,),
                        decoration: BoxDecoration(color: Theme.of(context).highlightColor,
                          border: Border.all(width: .5,color: Theme.of(context).hintColor.withOpacity(.5)),
                          borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),),
                        alignment: Alignment.center,
                        child: DropdownButtonFormField<int>(
                          value: deliveryMan.deliveryManIndex,
                          isExpanded: true,
                          decoration: const InputDecoration(border: InputBorder.none),
                          iconSize: 24, elevation: 16, style: titilliumRegular,
                          items: deliveryMan.deliveryManIds.map((int? value) {
                            return DropdownMenuItem<int>(
                              value: deliveryMan.deliveryManIds.indexOf(value),
                              child: Text(value != 0?
                              '${deliveryMan.deliveryManList![(deliveryMan.deliveryManIds.indexOf(value) -1)].fName} '
                                  '${deliveryMan.deliveryManList![(deliveryMan.deliveryManIds.indexOf(value) -1)].lName}':
                              getTranslated('select_delivery_man', context)!,
                                style: TextStyle(color: ColorResources.getTextColor(context)),),);
                          }).toList(),
                          onChanged: (int? value) {
                            deliveryMan.setDeliverymanIndex(value, true);
                            deliveryMan.assignDeliveryMan(context,widget.orderId, deliveryMan.deliveryManList![value!-1].id);
                          },
                        ),),),],),

                      const SizedBox(height: Dimensions.paddingSizeDefault,),
                      Text(getTranslated('additional_delivery_man_fee', context)!, style: robotoRegular,),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                        child: CustomTextField(hintText: getTranslated('delivery_man_charge', context),
                        border: true,
                        controller: _deliveryManCharge,
                        isAmount: true,),
                      ),
                      const SizedBox(height: Dimensions.paddingSizeSmall),
                      Text(getTranslated('expected_delivery_date', context)!, style: robotoRegular,),
                      const SizedBox(height: Dimensions.paddingSizeSmall),
                      Consumer<OrderProvider>(
                        builder: (context, orderProvider,_) {
                          String expectedDate = orderProvider.startDate != null  ?

                          orderProvider.dateFormat.format(orderProvider.startDate!) :widget.orderModel!.expectedDeliveryDate != null?
                          widget.orderModel!.expectedDeliveryDate!:
                          getTranslated('expected_delivery_date', context)!;
                          String dateForDelivery  = _expectedDeliveryDate.text = expectedDate;
                          String deliveryCharge  = _deliveryManCharge.text;

                          return InkWell(
                            onTap : (){
                              orderProvider.selectDate(context);
                              orderProvider.setDeliveryCharge(orderId: widget.orderId, deliveryCharge: deliveryCharge,deliveryDate: dateForDelivery, context: context);
                            },
                            child: CustomTextField(
                              hintText: widget.orderModel!.expectedDeliveryDate ?? getTranslated('expected_delivery_date', context),
                            border: true,
                            controller: _expectedDeliveryDate,
                              idDate: true,
                            ),
                          );
                        }
                      ),




                    ],
                  );}),) :
              delivery.selectedDeliveryTypeIndex == 2?
              Padding(padding: const EdgeInsets.only(bottom: 20.0),
                child: Column(crossAxisAlignment: CrossAxisAlignment.end,
                  children: [Row(children: [
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(getTranslated('third_party_delivery_service', context)!,
                        style: robotoRegular.copyWith(),),
                      const SizedBox(height: Dimensions.paddingSizeSmall),


                      CustomTextField(
                        border: true,
                        hintText: 'Ex: xyz service',
                        controller: _thirdPartyShippingNameController,
                        focusNode: _thirdPartyShippingNameNode,
                        nextNode: _thirdPartyShippingIdNode,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.name,
                        isAmount: false,
                      ),],),),
                    const SizedBox(width: Dimensions.paddingSizeExtraSmall),


                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(getTranslated('third_party_delivery_tracking_id', context)!,
                        style: robotoRegular),
                      const SizedBox(height: Dimensions.paddingSizeSmall),
                      CustomTextField(
                        hintText: 'Ex: xyz-12345678',
                        border: true,
                        controller: _thirdPartyShippingIdController,
                        focusNode: _thirdPartyShippingIdNode,
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.text,
                        isAmount: false,
                      ),
                    ],),),
                  ],),
                    const SizedBox(height: Dimensions.paddingSizeSmall),



                    Consumer<OrderProvider>(
                        builder: (context, order,_) {
                          return order.assigning ? Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor)) :
                          SizedBox( width: 120,
                            child: CustomButton(btnTxt: getTranslated('add', context), onTap: (){
                              String serviceName =_thirdPartyShippingNameController.text.trim().toString();
                              String trackingId =_thirdPartyShippingIdController.text.trim().toString();

                              if(serviceName.isEmpty){
                                showCustomSnackBar(getTranslated('delivery_service_provider_name_required',context), context);
                              } else{
                                order.assignThirdPartyDeliveryMan(context, serviceName, trackingId, widget.orderModel!.id).then((value) {
                                  if(value.response!.statusCode == 200){
                                    Navigator.pop(context);
                                  }
                                });
                              }},),
                          );
                        }
                    )
                  ],
                ),
              ):const SizedBox(),
            ],
          ):const SizedBox(),

        ]);
      }
    );
  }
}
