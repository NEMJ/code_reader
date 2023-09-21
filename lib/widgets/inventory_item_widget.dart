import 'package:flutter/material.dart';

class InventoryItemWidget extends StatefulWidget {
  const InventoryItemWidget({
    super.key,
    required this.code,
    this.onPressed,
  });

  final String code;
  final void Function()? onPressed;

  @override
  State<InventoryItemWidget> createState() => _InventoryItemWidgetState();
}

class _InventoryItemWidgetState extends State<InventoryItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: ListTile(
        title: Text(widget.code),
        tileColor: Colors.blueGrey[50],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        trailing: IconButton(
          onPressed: (widget.onPressed != null) ? widget.onPressed : () {},
          color: Colors.red,
          iconSize: 20,
          icon: const Icon(Icons.delete),
        ),
        contentPadding: const EdgeInsets.only(left: 14, right: 8),
        onTap: () => print("Item ${widget.code} Clicado"),
      ),
    );
  }
}