import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/data/model/response/top_delivery_man.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/delivery_man_provider.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/screens/bank_info/widget/bank_info_widget.dart';
import 'package:sixvalley_vendor_app/view/screens/delivery/widget/balance_statement_widget.dart';
import 'package:sixvalley_vendor_app/view/screens/delivery/widget/delivery_man_card.dart';
import 'package:sixvalley_vendor_app/view/screens/delivery/widget/delivery_man_withdraw_cash.dart';
import 'package:sixvalley_vendor_app/view/screens/delivery/withdraw/withdraw_details_screen.dart';

class DeliveryManOverViewScreen extends StatelessWidget {
  final DeliveryMan? deliveryMan;
  const DeliveryManOverViewScreen({Key? key, this.deliveryMan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Consumer<DeliveryManProvider>(
        builder: (context, deliveryManProvider,_) {
          return Column(
              children: [
                DeliveryManCardWidget(deliveryMan: deliveryMan, isDetails: true),

                DeliveryManWithdrawBalanceWidget(deliveryManProvider: deliveryManProvider),
                const SizedBox(height: Dimensions.paddingSizeDefault),

                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    boxShadow: [BoxShadow(color: Theme.of(context).primaryColor.withOpacity(.125), blurRadius: 1, spreadRadius: 1, offset: const Offset(0,1))]
                  ),
                  child: Column(children: [

                    BalanceStatementWidget(icon: Images.currentBalance, text: getTranslated('current_balance', context),
                        color: Colors.green[900],amount: deliveryManProvider.deliveryManDetails?.deliveryMan?.wallet != null ?
                        double.parse(deliveryManProvider.deliveryManDetails!.deliveryMan!.wallet!.currentBalance!) : 0),
                    const Divider(),
                    BalanceStatementWidget(icon: Images.withdrawableBalance, text: getTranslated('withdrawable_balance', context),
                        color: Colors.orange,amount: deliveryManProvider.deliveryManDetails?.withdrawbaleBalance != null ?
                        deliveryManProvider.deliveryManDetails!.withdrawbaleBalance : 0),
                    const Divider(),
                    BalanceStatementWidget(icon: Images.pendingWithdraw, text: getTranslated('pending_withdraw', context),
                        color: Colors.green,amount: deliveryManProvider.deliveryManDetails?.deliveryMan?.wallet != null ?
                        double.parse(deliveryManProvider.deliveryManDetails!.deliveryMan!.wallet!.pendingWithdraw!) : 0),
                    const Divider(),
                    BalanceStatementWidget(icon: Images.totalWithdrawn, text: getTranslated('total_withdrawn', context),
                        color: Theme.of(context).primaryColor, amount: deliveryManProvider.deliveryManDetails?.deliveryMan?.wallet != null ?
                        double.parse(deliveryManProvider.deliveryManDetails!.deliveryMan!.wallet!.totalWithdraw!) : 0),
                    const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                ],),),


                const SizedBox(height: Dimensions.paddingSizeDefault),
                Padding(
                  padding: const EdgeInsets.only(right: Dimensions.paddingSizeSmall,left: Dimensions.paddingSizeSmall, bottom: Dimensions.paddingSizeMedium),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(text: '${getTranslated('details_information', context)}',
                                style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).primaryColor)),
                          ],
                        ),
                      ),
                    ),


                  ],),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                      boxShadow: [BoxShadow(color: Theme.of(context).primaryColor.withOpacity(.125), blurRadius: 1,spreadRadius: 1,offset: const Offset(0,1))]


                  ),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [


                    const SizedBox(height: Dimensions.paddingSizeSmall,),
                    InfoItem(icon: Images.callIcon, title: '${deliveryManProvider.deliveryManDetails?.deliveryMan?.countryCode??''} ${deliveryManProvider.deliveryManDetails?.deliveryMan?.phone??''}'),
                    InfoItem(icon: Images.emailIcon, title: deliveryManProvider.deliveryManDetails?.deliveryMan?.email??''),
                    InfoItem(icon: Images.address, title: deliveryManProvider.deliveryManDetails?.deliveryMan?.address??''),


                    const SizedBox(height: Dimensions.paddingSizeSmall,),

                  ],),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeSmall, Dimensions.paddingSizeDefault,
                      Dimensions.paddingSizeSmall, Dimensions.paddingSizeMedium),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                        child: Text(getTranslated('bank_information', context)!,
                          style: robotoMedium.copyWith(color: Theme.of(context).primaryColor, fontSize: Dimensions.fontSizeLarge),),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Theme.of(context).cardColor,
                  child: BankInfoWidget(
                    name: deliveryManProvider.deliveryManDetails?.deliveryMan?.holderName?? getTranslated('no_data_found', context),
                    bank: deliveryManProvider.deliveryManDetails?.deliveryMan?.bankName?? getTranslated('no_data_found', context),
                    branch: deliveryManProvider.deliveryManDetails?.deliveryMan?.branch?? getTranslated('no_data_found', context),
                    accountNo: deliveryManProvider.deliveryManDetails?.deliveryMan?.accountNo?? getTranslated('no_data_found', context),
                  ),
                ),

              ],

          );
        }
      ),
    );
  }
}
