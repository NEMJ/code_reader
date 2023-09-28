import 'package:flutter/material.dart';

class InventoryWidget extends StatefulWidget {
  const InventoryWidget({
    super.key,
    required this.title,
    this.buttonOnPressed,
  });

  final String title;
  final VoidCallback? buttonOnPressed;

  @override
  State<InventoryWidget> createState() => _InventoryWidgetState();
}

class _InventoryWidgetState extends State<InventoryWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: ListTile(
        title: Text(widget.title),
        tileColor: Colors.blueGrey[50],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        trailing: IconButton(
          onPressed: (widget.buttonOnPressed != null) ? widget.buttonOnPressed : () {},
          // icon: const Icon(Icons.more_vert),
          icon: const Icon(Icons.cancel_outlined),
          color: Colors.red,
          iconSize: 20,
        ),
        contentPadding: const EdgeInsets.only(left: 14, right: 8),
        onTap: () => print("Inventário ${widget.title} Clicado"),
      ),
    );
  }
}