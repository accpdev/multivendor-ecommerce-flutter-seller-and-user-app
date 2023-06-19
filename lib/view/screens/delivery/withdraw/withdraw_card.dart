
import 'package:flutter/material.dart';
import 'package:sixvalley_vendor_app/data/model/response/delivery_man_withdraw_model.dart';
import 'package:sixvalley_vendor_app/helper/date_converter.dart';
import 'package:sixvalley_vendor_app/helper/price_converter.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/screens/delivery/withdraw/withdraw_details_screen.dart';

class WithdrawCardWidget extends StatelessWidget {
  final Withdraws? withdraw;
  final int? index;
  final bool isDetails;
  const WithdrawCardWidget({Key? key, this.withdraw, this.index, this.isDetails = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if(!isDetails){
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => WithdrawDetailsScreen (withdraw: withdraw, index: index,)));
        }
      },

      child: Padding(
        padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeExtraSmall,0,Dimensions.paddingSizeExtraSmall,Dimensions.paddingSizeSmall),
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
              boxShadow: [BoxShadow(color: Theme.of(context).primaryColor.withOpacity(.125), blurRadius: 1,spreadRadius: 1,offset: const Offset(1,2))]


          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [

            Container(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(Dimensions.paddingSizeExtraSmall),
                      topRight: Radius.circular(Dimensions.paddingSizeExtraSmall)),
                color: Theme.of(context).cardColor,
                boxShadow: [BoxShadow(color: Theme.of(context).primaryColor.withOpacity(.07), blurRadius: 1, spreadRadius: 1, offset: const Offset(0,1))]
              ),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: '${getTranslated('xid', context)}# ', style: robotoRegular),
                      TextSpan(
                        text: withdraw!.id.toString(),
                        style: robotoMedium,
                      ),

                    ],
                  ),
                ),

                Container(padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                  decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(.07),
                  borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),),
                  child: Text(PriceConverter.convertPrice(context, withdraw!.amount),
                    style: robotoMedium.copyWith(color: Theme.of(context).primaryColor),),)
              ],),
            ),
            const SizedBox(height: Dimensions.paddingSizeSmall,),
            Padding(
              padding: const EdgeInsets.only(right: Dimensions.paddingSizeSmall,left: Dimensions.paddingSizeSmall,
                  top: Dimensions.paddingSizeExtraSmall, bottom: Dimensions.paddingSizeExtraSmall),
              child: Text(DateConverter.localDateToIsoStringAMPM(DateTime.parse(withdraw!.createdAt!)),
                  style: robotoRegular.copyWith(color: Theme.of(context).hintColor)),
            ),
            const SizedBox(height: Dimensions.paddingSizeExtraSmall,),


            Padding(
              padding: isDetails? const EdgeInsets.fromLTRB(Dimensions.paddingSizeSmall, 0, Dimensions.paddingSizeSmall, Dimensions.paddingSizeDefault):
              const EdgeInsets.only(left: Dimensions.paddingSizeSmall, bottom: Dimensions.paddingSizeSmall, right: Dimensions.paddingSizeSmall),
              child: Row( mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  withdraw!.approved ==1 ?
                  const Icon(Icons.check_circle, size: Dimensions.iconSizeSmall,color: Colors.green):
                  withdraw!.approved ==2 ?
                  const Icon(Icons.cancel, size: Dimensions.iconSizeSmall, color: Colors.red):
                  Icon(Icons.watch_later, size: Dimensions.iconSizeSmall, color: Theme.of(context).primaryColor),
                  Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                    child: Text(withdraw!.approved ==1 ?
                    getTranslated('approved', context)! :
                    withdraw!.approved ==2 ?
                    getTranslated('denied', context)!:
                    getTranslated('pending', context)!,
                        style: robotoRegular.copyWith(color:
                        withdraw!.approved ==1 ?
                        Colors.green:
                        withdraw!.approved ==2 ?
                        Colors.red:
                        Theme.of(context).primaryColor
                        )
                    ),
                  ),


                ],
              ),
            ),

            withdraw!.transactionNote != null?
            Padding(
              padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeSmall, Dimensions.paddingSizeSmall,
                  Dimensions.paddingSizeSmall, Dimensions.paddingSizeSmall),
              child: Text('${getTranslated('note', context)} : ${withdraw!.transactionNote}',
                maxLines: isDetails ? 50 : 1,
                overflow: TextOverflow.ellipsis,
                style: robotoRegular.copyWith(color: ColorResources.getTextColor(context).withOpacity(.9)),),
            ): const SizedBox()

          ],),
        ),
      ),
    );
  }
}

