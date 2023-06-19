import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/data/model/response/top_delivery_man.dart';
import 'package:sixvalley_vendor_app/helper/price_converter.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/delivery_man_provider.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/base/title_row.dart';
import 'package:sixvalley_vendor_app/view/screens/delivery/widget/delivery_man_earning_view_all_screen.dart';
import 'package:sixvalley_vendor_app/view/screens/delivery/widget/delivery_man_earning_list_view.dart';


class DeliveryManEarningList extends StatefulWidget {
  final DeliveryMan? deliveryMan;
  const DeliveryManEarningList({Key? key, this.deliveryMan}) : super(key: key);

  @override
  State<DeliveryManEarningList> createState() => _DeliveryManEarningListState();
}

class _DeliveryManEarningListState extends State<DeliveryManEarningList> {
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Consumer<DeliveryManProvider>(
        builder: (context, earningProvider,_) {
          String totalWithDrawn = earningProvider.deliveryManEarning?.deliveryMan?.wallet?.totalWithdraw??'0';
          return Column(
            children: [
              EarningItemCard(amount: earningProvider.deliveryManEarning?.totalEarn, title: 'total_earning',icon: Images.totalEarning),
              EarningItemCard(amount: earningProvider.deliveryManEarning?.withdrawableBalance, title: 'withdrawable_balance',icon: Images.withdrawableBalanceIcon),
              EarningItemCard(amount: double.parse(totalWithDrawn), title: 'already_withdrawn',icon: Images.alreadyWithdrawnIcon),



              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeMedium, vertical: Dimensions.paddingSizeExtraSmall),
                child: TitleRow(title: getTranslated('earning_statement', context), onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=> DeliveryManEarningViewAllScreen(deliveryMan: widget.deliveryMan)));
                },),
              ),

              DeliverymanEarningListView(deliveryMan: widget.deliveryMan, scrollController: _scrollController,),
            ],
          );
        }
      ),
    );
  }
}


class EarningItemCard extends StatelessWidget {
  final double? amount;
  final String? title;
  final String? icon;
  const EarningItemCard({Key? key, this.amount, this.title, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeMedium,0, Dimensions.paddingSizeMedium, Dimensions.paddingSizeSmall ),
      child: Container(
        padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
            boxShadow: [BoxShadow(color: Theme.of(context).primaryColor.withOpacity(.125), blurRadius: 1, spreadRadius: 1, offset: const Offset(0,1))]
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center, children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(PriceConverter.convertPrice(context, amount), style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeMaxLarge),),
              const SizedBox(height: Dimensions.paddingSizeMedium,),
              Text(getTranslated(title, context)!,
                  style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).hintColor))
            ],),
            SizedBox(width: Dimensions.iconSizeExtraLarge,child: Image.asset(icon!),),
          ],),),
    );
  }
}
