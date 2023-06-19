import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/data/model/response/top_selling_product_model.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/product_provider.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/view/base/no_data_screen.dart';
import 'package:sixvalley_vendor_app/view/base/paginated_list_view.dart';
import 'package:sixvalley_vendor_app/view/base/title_row.dart';
import 'package:sixvalley_vendor_app/view/screens/product/product_list_view_screen.dart';
import 'package:sixvalley_vendor_app/view/screens/product/widget/top_most_product_card.dart';

class TopSellingProductScreen extends StatelessWidget {
  final bool isMain;
  final ScrollController? scrollController;
  const TopSellingProductScreen({Key? key, this.isMain = false, this.scrollController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async{
        Provider.of<ProductProvider>(context,listen: false).getTopSellingProductList(1, context, 'en');
      },
      child: Consumer<ProductProvider>(
        builder: (context, prodProvider, child) {
          List<Products>? productList;
          productList = prodProvider.topSellingProductModel?.products;


          return Column(mainAxisSize: MainAxisSize.min, children: [

            isMain?
            Padding(
              padding: const EdgeInsets.symmetric(horizontal : Dimensions.paddingSizeDefault,
                  vertical: Dimensions.paddingSizeSmall),
              child: Row(
                children: [
                  SizedBox(width: Dimensions.iconSizeDefault, child: Image.asset(Images.topSellingIcon)),
                  const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                  Expanded(
                    child: TitleRow(title: '${getTranslated('top_selling_products', context)}',
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProductListScreen(title: 'top_selling_products')))),
                  ),
                ],
              ),
            ):const SizedBox(),

            productList != null ? productList.isNotEmpty ?
            Padding(
              padding: const EdgeInsets.symmetric(horizontal : Dimensions.paddingSizeSmall,
                  vertical: Dimensions.paddingSizeSmall),
              child: PaginatedListView(
                reverse: false,
                scrollController: scrollController,
                totalSize: prodProvider.topSellingProductModel!.totalSize,
                offset: prodProvider.topSellingProductModel != null ? int.parse(prodProvider.topSellingProductModel!.offset!) : null,
                onPaginate: (int? offset) async {
                  await prodProvider.getTopSellingProductList(offset!, context,'en', reload: false);
                },

                itemView: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 9,
                    crossAxisSpacing: 5,
                    childAspectRatio: MediaQuery.of(context).size.width < 400? 1/1.23: MediaQuery.of(context).size.width < 415? 1/1.22 : 1/1.28,
                  ),
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: isMain && productList.length >4? 4 : productList.length,
                  itemBuilder: (context, index) {

                    return TopMostProductWidget(productModel: productList![index].product, totalSold: productList[index].count);
                  },
                ),
              ),




            ):  Padding(padding: EdgeInsets.only(top: isMain ? 0.0 :MediaQuery.of(context).size.height/3),
              child: const NoDataScreen()) :const SizedBox.shrink(),

            prodProvider.isLoading ? Center(child: Padding(
              padding: const EdgeInsets.all(Dimensions.iconSizeExtraSmall),
              child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)),
            )) : const SizedBox.shrink(),

          ]);
        },
      ),
    );
  }
}
