import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/transaction_provider.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/base/custom_app_bar.dart';
import 'package:sixvalley_vendor_app/view/base/no_data_screen.dart';
import 'package:sixvalley_vendor_app/view/screens/transaction/widget/transaction_widget.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({Key? key}) : super(key: key);



  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {


  void _loadData(BuildContext context){
    Provider.of<TransactionProvider>(context, listen: false).getTransactionList(context, 'all','','');
    Provider.of<TransactionProvider>(context, listen: false).initMonthTypeList();
    Provider.of<TransactionProvider>(context, listen: false).initYearList();
  }

  double filterHeight = 45;


  TextEditingController searchController = TextEditingController();


  @override
  void initState() {
    super.initState();
    _loadData(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: getTranslated('transactions', context), isAction: true),
      body: Consumer<TransactionProvider>(
        builder: (context, transactionProvider, child) {

          return Column(children: [
            SizedBox(height: 65,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: const [
                    TransactionTypeButton(text: 'all', index: 0),
                    TransactionTypeButton(text: 'pending', index: 1),
                    TransactionTypeButton(text: 'approved', index: 2),
                    TransactionTypeButton(text: 'denied', index: 3),
                  ],
                )),

              Expanded(child: transactionProvider.transactionList != null ? transactionProvider.transactionList!.isNotEmpty ?

               ListView.builder(itemCount: transactionProvider.transactionList!.length,
                  itemBuilder: (context, index) => TransactionWidget(
                      transactionModel: transactionProvider.transactionList![index])):
               const NoDataScreen() : Center(child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor))),
              ),
            ],
          );
        }
      ),
    );
  }
}

class TransactionTypeButton extends StatelessWidget {
  final String text;
  final int index;
  const TransactionTypeButton({Key? key, required this.text, required this.index,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall, vertical: Dimensions.paddingSizeMedium),
        child: InkWell(
          onTap: (){
            Provider.of<TransactionProvider>(context, listen: false).setIndex(context, index);
          },
          child: Consumer<TransactionProvider>(builder: (context, transactionProvider, child) {
            return Container(
              height: 45,
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge,),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: transactionProvider.transactionTypeIndex == index ? Theme.of(context).primaryColor : ColorResources.getButtonHintColor(context),
                borderRadius: BorderRadius.circular(Dimensions.paddingSizeLarge),
              ),
              child: Text(getTranslated(text, context)!, style: transactionProvider.transactionTypeIndex == index
                  ? titilliumBold.copyWith(color: transactionProvider.transactionTypeIndex == index
                  ? ColorResources.getWhite(context) : ColorResources.getTextColor(context)):
              robotoRegular.copyWith(color: transactionProvider.transactionTypeIndex == index
                  ? ColorResources.getWhite(context) : ColorResources.getTextColor(context))),
            );
          },
          ),
        ),
      ),
    );
  }
}