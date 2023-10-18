import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../models/inventory_model.dart';
import 'package:share_extend/share_extend.dart';

class InventoryWidget extends StatefulWidget {
  const InventoryWidget({
    super.key,
    required this.inventory,
    this.actionButtonOnPressed,
    this.onTap,
  });

  final InventoryModel inventory;
  final Function(BuildContext)? actionButtonOnPressed;
  final Function()? onTap;

  @override
  State<InventoryWidget> createState() => _InventoryWidgetState();
}

class _InventoryWidgetState extends State<InventoryWidget> {

  void share(BuildContext context) {
    ShareExtend.share("share text", "text", subject: "Teste", extraText: "testando");
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Slidable(
        endActionPane: ActionPane(
          extentRatio: 0.5,
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              padding: EdgeInsets.zero,
              onPressed: widget.actionButtonOnPressed,
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete_rounded,
              label: "Excluir",
            ),
            SlidableAction(
              padding: EdgeInsets.zero,
              onPressed: share,
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              icon: Icons.share,
              label: "Compartilhar",
            ),
          ],
        ),
        child: ListTile(
          title: Text(widget.inventory.title),
          subtitle: Text("Itens: ${widget.inventory.codes.length}"),
          tileColor: Colors.blueGrey[50],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          contentPadding: const EdgeInsets.only(left: 18, right: 6),
          onTap: widget.onTap,
        ),
      ),
    );
  }
}