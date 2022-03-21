import 'package:flutter/cupertino.dart';
import 'package:scanner/mainscreen/utils/constants.dart';

class RadioSelectButton extends StatefulWidget {
  const RadioSelectButton({Key? key}) : super(key: key);

  @override
  State<RadioSelectButton> createState() => _RadioSelectButtonState();
}

class _RadioSelectButtonState extends State<RadioSelectButton> {
  @override
  Widget build(BuildContext context) {
    bool isClick = false;
    return GestureDetector(
      onTap: () {
        setState(() {
          isClick = !isClick;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        height: 10,
        width: 10,
        decoration:
            BoxDecoration(border: Border.all(color: primaryColor, width: 1.5)),
        child: (!isClick)
            ? Container(
                decoration: const BoxDecoration(
                    color: primaryColor, shape: BoxShape.circle),
              )
            : const SizedBox(),
      ),
    );
  }
}
