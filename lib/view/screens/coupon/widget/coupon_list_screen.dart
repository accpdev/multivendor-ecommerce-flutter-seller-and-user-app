import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/data/model/response/coupon_model.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/coupon_provider.dart';
import 'package:sixvalley_vendor_app/view/base/custom_app_bar.dart';
import 'package:sixvalley_vendor_app/view/base/no_data_screen.dart';
import 'package:sixvalley_vendor_app/view/base/paginated_list_view.dart';
import 'package:sixvalley_vendor_app/view/screens/coupon/widget/add_new_coupon_screen.dart';
import 'package:sixvalley_vendor_app/view/screens/coupon/widget/coupon_card.dart';
import 'package:sixvalley_vendor_app/view/screens/order/order_screen.dart';



class CouponListScreen extends StatefulWidget {
  const CouponListScreen({Key? key}) : super(key: key);
  @override
  State<CouponListScreen> createState() => _CouponListScreenState();
}

class _CouponListScreenState extends State<CouponListScreen> {

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    Provider.of<CouponProvider>(context, listen: false).getCouponList(context,1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: getTranslated('coupon_list', context)),
      body: Consumer<CouponProvider>(
        builder: (context, couponProvider,_) {
          List<Coupons> couponList;
          couponList = couponProvider.couponList;
          return !couponProvider.isLoading? couponList.isNotEmpty?

          SingleChildScrollView(
            controller: scrollController,
            child: PaginatedListView(
              reverse: false,
              scrollController: scrollController,
              totalSize: couponProvider.couponModel!.totalSize,
              offset: couponProvider.couponModel != null ? int.parse(couponProvider.couponModel!.offset!) : null,
              onPaginate: (int? offset) async {
                await couponProvider.getCouponList(context, offset!, reload: false);
              },

              itemView:  ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                  itemCount: couponProvider.couponList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index){
                  return CouponCard(coupons: couponList[index], index: index,);
                }),
            ),
          ):const NoDataScreen(): const OrderShimmer();
        }
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).cardColor,
        child: Icon(Icons.add,color: Theme.of(context).primaryColor,),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (_)=> const AddNewCouponScreen()));
        },
      ),
    );
  }
}
