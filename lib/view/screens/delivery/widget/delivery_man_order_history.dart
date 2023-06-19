import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/data/model/response/order_model.dart';
import 'package:sixvalley_vendor_app/data/model/response/top_delivery_man.dart';
import 'package:sixvalley_vendor_app/provider/delivery_man_provider.dart';
import 'package:sixvalley_vendor_app/view/base/no_data_screen.dart';
import 'package:sixvalley_vendor_app/view/screens/delivery/widget/delivery_man_order_history_card.dart';


class DeliveryManOrderListScreen extends StatelessWidget {
  final DeliveryMan? deliveryMan;
  const DeliveryManOrderListScreen({Key? key, this.deliveryMan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DeliveryManProvider>(
      builder: (context, order, child) {
        List<Order> orderList = [];
        orderList = order.deliverymanOrderList;
        return  order.deliverymanOrderList.isNotEmpty ?
        RefreshIndicator(
          backgroundColor: Theme.of(context).primaryColor,
          onRefresh: () async {
            await order.getDeliveryManOrderListHistory(context,1,deliveryMan!.id);
          },
          child: ListView.builder(
            itemCount: orderList.length,
            padding: const EdgeInsets.all(0),
            itemBuilder: (context, index) {
              return DeliveryManOrderWidget(orderModel: orderList[index]);
            }
          ),
        ) : const NoDataScreen(title: 'no_order_found');
      }
    );
  }
}
