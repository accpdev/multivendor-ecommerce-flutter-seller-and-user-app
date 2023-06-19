import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/data/model/response/top_delivery_man.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/delivery_man_provider.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/view/base/no_data_screen.dart';
import 'package:sixvalley_vendor_app/view/base/title_row.dart';
import 'package:sixvalley_vendor_app/view/screens/top_delivery_man/top_delivery_man_screen.dart';
import 'package:sixvalley_vendor_app/view/screens/top_delivery_man/widget/top_delivery_man_widget.dart';



class TopDeliveryManView extends StatelessWidget {
  final bool isMain;
  const TopDeliveryManView({Key? key, this.isMain = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DeliveryManProvider>(
      builder: (context, deliveryProvider, child) {
        List<DeliveryMan>? deliveryManList;
        deliveryManList = deliveryProvider.topDeliveryManList;


        return Column(mainAxisSize: MainAxisSize.min, children: [

          isMain?
          Padding(
            padding: const EdgeInsets.symmetric(horizontal : Dimensions.paddingSizeDefault,
                vertical: Dimensions.paddingSizeSmall),
            child: Row(
              children: [
                SizedBox(width: Dimensions.iconSizeDefault, child: Image.asset(Images.topDeliveryMan)),
                const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                Expanded(
                  child: TitleRow(title: '${getTranslated('top_delivery_man', context)}',
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TopDeliveryMAnScreen()))),
                ),
              ],
            ),
          ):const SizedBox(),

          !deliveryProvider.isLoading ? deliveryManList!.isNotEmpty ?
          Padding(
            padding: const EdgeInsets.symmetric(horizontal : Dimensions.paddingSizeSmall,
                vertical: Dimensions.paddingSizeSmall),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                childAspectRatio: MediaQuery.of(context).size.width < 400? 1/1.12: MediaQuery.of(context).size.width < 420? 1/.97 : 1/.95,
              ),
              padding: const EdgeInsets.all(0),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: isMain && deliveryManList.length > 4 ? 4: deliveryManList.length,
              itemBuilder: (context, index) {

                return TopDeliveryManWidget(deliveryMan : deliveryManList![index]);
              },
            ),
          ): Padding(padding: EdgeInsets.only(top: isMain ? 0.0 :MediaQuery.of(context).size.height/3),
            child: const NoDataScreen(),
          ) :const SizedBox.shrink(),

          deliveryProvider.isLoading ? Center(child: Padding(padding: const EdgeInsets.all(Dimensions.iconSizeExtraSmall),
            child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)),
          )) : const SizedBox.shrink(),

        ]);
      },
    );
  }
}
