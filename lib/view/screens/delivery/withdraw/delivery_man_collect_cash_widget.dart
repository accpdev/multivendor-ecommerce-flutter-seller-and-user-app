import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/helper/price_converter.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/delivery_man_provider.dart';
import 'package:sixvalley_vendor_app/provider/splash_provider.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/base/custom_button.dart';
import 'package:sixvalley_vendor_app/view/base/custom_snackbar.dart';




class CollectedCashFromDeliveryManDialog extends StatefulWidget {
  final double? totalCashInHand;
  final int? deliveryManId;
  const CollectedCashFromDeliveryManDialog({Key? key, this.totalCashInHand, this.deliveryManId}) : super(key: key);
  @override
  CollectedCashFromDeliveryManDialogState createState() => CollectedCashFromDeliveryManDialogState();
}

class CollectedCashFromDeliveryManDialogState extends State<CollectedCashFromDeliveryManDialog> {
  bool isTextFieldEmpty = true;

  final TextEditingController _balanceController = TextEditingController();

  List<String> suggestedValue = ['500', '1000', '2000', '5000', '10000'];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {

    return Padding(padding: const EdgeInsets.only(top: 70),
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Container(
          decoration: BoxDecoration(
            color: ColorResources.getBottomSheetColor(context),
            borderRadius: const BorderRadius.only(
                topLeft:  Radius.circular(25),
                topRight: Radius.circular(25)),
          ),
          child: Consumer<DeliveryManProvider>(
            builder: (context, deliverymanProvider, child)
                {
                  return Container(
                    padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, 100, Dimensions.paddingSizeDefault, 0),
                    child: Column(
                      children: [


                        Row(mainAxisAlignment : MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Expanded(child: SizedBox()),

                            IntrinsicWidth(
                              child: TextFormField(
                                inputFormatters: [
                                 LengthLimitingTextInputFormatter(20),
                                ],
                                keyboardType: TextInputType.number,
                                controller: _balanceController,
                                textAlignVertical: TextAlignVertical.center,
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                decoration: InputDecoration(
                                    border : InputBorder.none,
                                    isCollapsed: true,
                                    hintText: "Ex: 500",
                                    hintStyle: robotoBold.copyWith(
                                        fontSize: 20)
                                ),
                                style: robotoBold.copyWith(fontSize: Dimensions.fontSizeExtraLargeTwenty,
                                    color: ColorResources.getTextColor(context)),
                                onChanged: (String value){
                                  setState(() {
                                    if(value.isNotEmpty){
                                     isTextFieldEmpty = false;
                                    }else{
                                     isTextFieldEmpty = true;
                                    }
                                  });
                                },
                              ),
                            ),

                            Text(Provider.of<SplashProvider>(context, listen: false).myCurrency!.symbol!, 
                              style: robotoBold.copyWith(
                                  fontSize: Dimensions.fontSizeExtraLargeTwenty,
                                  color:isTextFieldEmpty? Theme.of(context).hintColor :
                              ColorResources.getTextColor(context)),),

                            const Expanded(child: SizedBox()),
                          ],
                        ),




                        Padding(
                          padding: const EdgeInsets.only(top: Dimensions.paddingSizeDefault, bottom: Dimensions.paddingSizeExtraSmall),
                          child: Row(mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('${getTranslated('available_balance', context)} : ', style: robotoRegular.copyWith(
                                color: Theme.of(context).hintColor
                              )),
                              Text(PriceConverter.convertPrice(context, widget.totalCashInHand??0),
                                  style: robotoRegular.copyWith(
                                      color: Theme.of(context).hintColor,
                                      fontSize: Dimensions.fontSizeDefault)),
                            ],
                          ),
                        ),

                        const Divider(),

                        Padding(
                          padding: const EdgeInsets.fromLTRB( Dimensions.paddingSizeSmall, Dimensions.paddingSizeSmall, Dimensions.paddingSizeSmall, 50),
                          child: SizedBox(height: 30,
                            child: ListView.builder(itemCount: 5,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index){
                              return GestureDetector(
                                onTap: (){
                                  setState(() {
                                    selectedIndex = index;
                                    _balanceController.text = suggestedValue[index];

                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeMedium, ),
                                    decoration: BoxDecoration(
                                      color: index == selectedIndex? Theme.of(context).primaryColor: Theme.of(context).cardColor,
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(color: index == selectedIndex? Theme.of(context).primaryColor: Theme.of(context).hintColor)
                                    ),
                                    child: Center(child: Text(suggestedValue[index], 
                                      style: robotoRegular.copyWith(color: index == selectedIndex?  Colors.white: ColorResources.getTextColor(context)),)),
                                  ),
                                ),
                              );
                                }),
                          ),
                        ),





                        !deliverymanProvider.isLoading?
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraLarge),
                          child: CustomButton(btnTxt: getTranslated('submit', context),onTap: (){
                            String amount = _balanceController.text.trim();
                            if(amount.isEmpty){
                              showCustomSnackBar(getTranslated('amount_is_required', context), context, isToaster: true);
                            }else{
                              deliverymanProvider.collectCashFromDeliveryMan(context, widget.deliveryManId, amount);
                            }

                          },),
                        ): Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor))),

                      ],
                    ),
                  );
                }


          ),

        ),
      ),
    );

  }


}
