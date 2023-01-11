import 'package:flutter/material.dart';
import '../../../Models/models.dart';

class IncomeStat extends StatelessWidget {
  List<OrdersModel> completeOrders;
  IncomeStat({super.key, required this.completeOrders});

  double total = 0.0;
  double earnings = 0.0;
  double orderQuantity = 0.0;
  totalCalculation(List<OrdersModel> completeOrders) {
    total = 0;
    earnings = 0;
    orderQuantity = 0;
    for (int i = 0; i < completeOrders.length; i++) {
      total = total + completeOrders[i].totalPrice;
      earnings = earnings + completeOrders[i].totalDistancePrice;
      orderQuantity = orderQuantity + 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    totalCalculation(completeOrders);
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10, bottom: 10),
      child: Container(
        height: 160.0,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Color(0xFFC5C5C5)),
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            const SizedBox(height: 10.0),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  DisplayRow('Total Sales', 'S\$${total.toStringAsFixed(2)}'),
                  DisplayRow('Earnings', 'S\$${earnings.toStringAsFixed(2)}'),
                  DisplayRow('Order Quantity', orderQuantity.toInt().toString())
                ],
              ),
            ),
            const SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }

  Widget DisplayRow(text, number) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(text,
                style: const TextStyle(
                  fontSize: 18.0,
                  color: Color.fromARGB(255, 0, 0, 0),
                )),
            Text(number,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 0, 0),
                )),
          ],
        ),
        const SizedBox(height: 10.0),
      ],
    );
  }
}
