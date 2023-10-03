import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class InventoryWidget extends StatefulWidget {
  const InventoryWidget({
    super.key,
    required this.title,
    this.actionButtonOnPressed,
    this.onTap,
  });

  final String title;
  final Function(BuildContext)? actionButtonOnPressed;
  final Function()? onTap;

  @override
  State<InventoryWidget> createState() => _InventoryWidgetState();
}

class _InventoryWidgetState extends State<InventoryWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Slidable(
        endActionPane: ActionPane(
          extentRatio: 0.3,
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: widget.actionButtonOnPressed,
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete_rounded,
              label: "Excluir",
            ),
          ],
        ),
        child: ListTile(
          title: Text(widget.title),
          tileColor: Colors.blueGrey[50],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          contentPadding: const EdgeInsets.only(left: 14, right: 8),
          onTap: widget.onTap,
        ),
      ),
    );
  }
}