import 'package:flutter/material.dart';

class OptionsContainer extends StatelessWidget {
  final List<Widget> children;
  
  const OptionsContainer({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      elevation: 0,
      color: Colors.grey.shade50,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(children.length * 2 - 1, (index) {
          if (index.isOdd) {
            return Divider(
              height: 1,
              color: Colors.grey.shade300,
            );
          }
          return children[index ~/ 2];
        }),
      ),
    );
  }
}
