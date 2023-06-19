import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/data/repository/ratting_model.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/cart_provider.dart';
import 'package:sixvalley_vendor_app/provider/product_provider.dart';
import 'package:sixvalley_vendor_app/provider/product_review_provider.dart';
import 'package:sixvalley_vendor_app/provider/profile_provider.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/view/base/custom_app_bar.dart';
import 'package:sixvalley_vendor_app/view/base/custom_search_field.dart';
import 'package:sixvalley_vendor_app/view/base/no_data_screen.dart';
import 'package:sixvalley_vendor_app/view/screens/order/order_screen.dart';
import 'package:sixvalley_vendor_app/view/screens/review/widget/review_filter_bottom_sheet.dart';
import 'package:sixvalley_vendor_app/view/screens/review/widget/review_full_view_screen.dart';
import 'package:sixvalley_vendor_app/view/screens/review/widget/review_widget.dart';



class ProductReview extends StatefulWidget {
  const ProductReview({Key? key}) : super(key: key);

  @override
  State<ProductReview> createState() => _ProductReviewState();
}

class _ProductReviewState extends State<ProductReview> {

  @override
  void initState() {
    Provider.of<CartProvider>(context, listen: false).getCustomerList(context);
    Provider.of<ProductProvider>(context, listen: false).initSellerProductList(Provider.of<ProfileProvider>(context, listen: false).
    userInfoModel!.id.toString(), 1, context, 'en','', reload: true);
    super.initState();
  }
  TextEditingController searchController = TextEditingController();
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    Provider.of<ProductReviewProvider>(context, listen: false).getReviewList( context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(title: getTranslated('reviews', context),),
      body: Consumer<ProductReviewProvider>(
        builder: (context, reviewProvider, child) {

          List<Reviews> reviewList;
          reviewList = reviewProvider.reviewList;
          return
          Column(
            children: [
              const SizedBox(height: Dimensions.paddingSizeSmall),

              Container(height: 85,
                color: Theme.of(context).canvasColor,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault,
                      Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault,
                      Dimensions.paddingSizeDefault),
                  child: CustomSearchField(
                    controller: searchController,
                    hint: getTranslated('search', context),
                    prefix: Images.iconsSearch,
                    iconPressed: () => (){},
                    onSubmit: (text) => (){},
                    onChanged: (value){
                      reviewProvider.searchReviewList(context, value);
                    },
                    isFilter: true,
                    filterAction: (){
                      showModalBottomSheet(
                          backgroundColor: Colors.transparent,
                          isScrollControlled: true,
                          context: context, builder: (_) => const ReviewFilterBottomSheet());
                    },
                  ),
                ),
              ),
              !reviewProvider.isLoading ? reviewList.isNotEmpty?
              Expanded(
                child: ListView.builder(
                  itemCount: reviewList.length,
                  padding: const EdgeInsets.all(0),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                        onTap: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) =>
                            ReviewFullViewScreen(reviewModel: reviewList[index],isDetails: true,index: index,))),
                        child: ReviewWidget(reviewModel: reviewList[index], index: index,));
                  },
                ),
              ): const Expanded(child: NoDataScreen()): const Expanded(child: OrderShimmer()),
            ],
          );
        },
      ),
    );
  }
}
