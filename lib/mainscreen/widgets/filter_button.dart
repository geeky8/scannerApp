import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scanner/mainscreen/screens/filter_screen.dart';
import 'package:scanner/mainscreen/store/orders/orders_store.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final store = context.read<OrdersStore>();
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Provider.value(
              value: store,
              child: const FilterScreen(),
            ),
          ),
        );
      },
      child: Container(
        decoration: const BoxDecoration(color: Colors.transparent),
        padding: const EdgeInsets.only(left: 3),
        alignment: Alignment.center,
        width: 35,
        height: 35,
        child: Row(
          children: List.generate(3, (index) {
            return const FilterIcon();
          }),
        ),
      ),
    );
  }
}

class FilterIcon extends StatelessWidget {
  const FilterIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 3),
      child: Container(
        height: 6,
        width: 6,
        decoration:
            const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
      ),
    );
  }
}
