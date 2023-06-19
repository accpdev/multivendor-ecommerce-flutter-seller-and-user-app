import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/helper/price_converter.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/bank_info_provider.dart';
import 'package:sixvalley_vendor_app/provider/splash_provider.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';

class TransactionChart extends StatefulWidget {

  const TransactionChart({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => TransactionChartState();
}

class TransactionChartState extends State<TransactionChart> {
  final Color leftBarColor = const Color(0xff4E9BF0);
  final Color rightBarColor = const Color(0xFFF4BE37);
  final double width = 5;


  List<FlSpot> _expanseChartList = [];

  List<FlSpot> _incomeChartList = [];


  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BankInfoProvider>(
      builder: (context,bankInfoProvider, _) {
        List<double> earnings = [];
        List<double> commissions = [];
        if(bankInfoProvider.userCommissions!=null && bankInfoProvider.userEarnings != null){
          for(double? earn in bankInfoProvider.userCommissions!) {
            earnings.add(PriceConverter.convertAmount(earn!, context));
          }
          for(double? commission in bankInfoProvider.userEarnings!) {
            commissions.add(PriceConverter.convertAmount(commission!, context));
          }
        }
        _expanseChartList = commissions.asMap().entries.map((e) {
          return FlSpot(e.key.toDouble(), e.value);
        }).toList();

        _incomeChartList = earnings.asMap().entries.map((e) {
          return FlSpot(e.key.toDouble(), e.value);
        }).toList();
        return AspectRatio(
          aspectRatio: 1,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[

                    Row(crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                      Container(width: Dimensions.iconSizeLarge,height: Dimensions.iconSizeLarge ,
                          padding: const EdgeInsets.only(left: Dimensions.paddingSizeExtraSmall),
                          child: Image.asset(Images.monthlyEarning)),
                      const SizedBox(width: Dimensions.paddingSizeSmall,),

                      Text(getTranslated('earning_statistic', context)!, style: robotoBold.copyWith(
                          color: ColorResources.getTextColor(context),
                          fontSize: Dimensions.fontSizeDefault),),

                        const Expanded(child: SizedBox(width: Dimensions.paddingSizeExtraLarge,)),
                        Container(
                          height: 50,width: 120,
                          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            border: Border.all(width: .7,color: Theme.of(context).hintColor.withOpacity(.3)),
                            borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),

                          ),
                          child: DropdownButton<String>(
                            value: bankInfoProvider.revenueFilterTypeIndex == 0 ? 'this_year' : bankInfoProvider.revenueFilterTypeIndex == 1 ?  'this_month' : 'this_week',
                            items: <String>['this_year', 'this_month', 'this_week' ].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(getTranslated(value, context)!, style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeDefault),),
                              );
                            }).toList(),
                            onChanged: (value) {
                              bankInfoProvider.setRevenueFilterName(context,value, true);
                              bankInfoProvider.setRevenueFilterType(value == 'this_year' ? 0 : value == 'this_month'? 1:2, true);

                            },
                            isExpanded: true,
                            underline: const SizedBox(),
                          ),
                        ),

                    ],),
                    const SizedBox(height: Dimensions.paddingSizeSmall,),

                    Row(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,
                      children: [Row(children: [
                        const Icon(Icons.circle,size: Dimensions.iconSizeSmall,
                            color: Color(0xFF4E9BF0)),
                        const SizedBox(width: Dimensions.paddingSizeExtraSmall,),
                        Text(getTranslated('your_earnings', context)!,
                          style: robotoSmallTitleRegular.copyWith(color: ColorResources.getTextColor(context),
                        fontSize: Dimensions.fontSizeDefault),),],),

                        const SizedBox(width : Dimensions.paddingSizeSmall,),

                        Row(children: [
                          Icon(Icons.circle,size: Dimensions.iconSizeSmall,
                              color: const Color(0xFFF4BE37).withOpacity(.5)),
                          const SizedBox(width: Dimensions.paddingSizeExtraSmall,),
                          Text(getTranslated('commission_given', context)!,
                               style: robotoSmallTitleRegular.copyWith(color: ColorResources.getTextColor(context),
                                   fontSize: Dimensions.fontSizeSmall),
                        ),
                           ],
                         ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 38,
                ),
                Expanded(
                  child: LineChart(LineChartData(
                    lineTouchData: lineTouchData1,
                    gridData: gridData,
                    titlesData: titlesData1,
                    borderData: borderData,
                    lineBarsData: lineBarsData1,
                    minX: 0,
                    maxX: double.parse((Provider.of<BankInfoProvider>(context, listen: false).earnings.length).toString()),
                    maxY: (Provider.of<BankInfoProvider>(context, listen: false).lim/Provider.of<SplashProvider>(context,listen: false).usdCurrency!.exchangeRate!) ,
                    minY: 0,
                  ),
                    swapAnimationDuration: const Duration(milliseconds: 250),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
              ],
            ),
          ),
        );
      }
    );
  }


  LineTouchData get lineTouchData1 => LineTouchData(
    handleBuiltInTouches: true,
    touchTooltipData: LineTouchTooltipData(
      tooltipBgColor: Theme.of(context).cardColor,
      tooltipBorder: BorderSide(width: 1, color: Theme.of(context).primaryColor)

    ),
  );

  FlTitlesData get titlesData1 => FlTitlesData(
    bottomTitles: AxisTitles(
      sideTitles: bottomTitles,
    ),
    leftTitles: AxisTitles(
      sideTitles: leftTitles,
    ),
    rightTitles: AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    topTitles: AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),

  );

  List<LineChartBarData> get lineBarsData1 => [
    lineChartBarDataExpense,
    lineChartBarDataIncome,
  ];

  LineTouchData get lineTouchData2 => LineTouchData(
    enabled: true,
  );

  FlTitlesData get titlesData2 => FlTitlesData(
    bottomTitles: AxisTitles(
      sideTitles: bottomTitles,
    ),
    leftTitles: AxisTitles(
      sideTitles: leftTitles,
    ),
    rightTitles: AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    topTitles: AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
  );






  SideTitles get bottomTitles => SideTitles(
    showTitles: true,
    reservedSize: 32,
    interval: Provider.of<BankInfoProvider>(context, listen: false).revenueFilterTypeIndex == 1 ? 4 : 1,
    // getTitlesWidget: bottomTitleWidgets,
  );
  SideTitles get leftTitles => SideTitles(
    showTitles: true,
    reservedSize: 52,
    // getTitlesWidget: bottomTitleWidgets,
  );

  FlGridData get gridData => FlGridData(show: true,drawVerticalLine: false, drawHorizontalLine: true);

  FlBorderData get borderData => FlBorderData(
    show: true,
    border: const Border(
      bottom: BorderSide(color: Color(0xff4e4965), width: 1),
      left: BorderSide(color: Colors.transparent),
      right: BorderSide(color: Colors.transparent),
      top: BorderSide(color: Colors.transparent),
    ),
  );


  LineChartBarData get lineChartBarDataExpense => LineChartBarData(
    isCurved: false,
    color:Theme.of(context).primaryColor,
    barWidth: Dimensions.barWidthFlowChart,
    isStrokeCapRound: true,
    dotData: FlDotData(show: false),
    gradient: LinearGradient(
      colors: gradientColors,
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ),
    belowBarData: BarAreaData(
      show: true,
      gradient: LinearGradient(
        colors: gradientColors
            .map((color) => color.withOpacity(0.4))
            .toList(),
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
    ),
    spots: _expanseChartList,
  );

  LineChartBarData get lineChartBarDataIncome => LineChartBarData(
    isCurved: false,
    color:Theme.of(context).primaryColor,
    barWidth: Dimensions.barWidthFlowChart,
    isStrokeCapRound: true,
    dotData: FlDotData(show: false),
    gradient: LinearGradient(
      colors: gradientColors,
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ),
    belowBarData: BarAreaData(
      show: true,
      gradient: LinearGradient(
        colors: commissionGradientColors
            .map((color) => color.withOpacity(.5))
            .toList(),
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
    ),
    spots: _incomeChartList,
  );

}

List<Color> gradientColors = [
  const Color(0xFF1B7FED),
  const Color(0xff4560ad),
];

List<Color> commissionGradientColors = [
  const Color(0xFFF4BE37),
  const Color(0xFFF4BE37),
];



