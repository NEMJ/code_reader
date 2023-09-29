import 'package:code_reader/widgets/inventory_widget.dart';
import 'package:flutter/material.dart';
import '../data/inventory_data.dart';
import '../models/inventory_model.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  InventoryData inventoryData = InventoryData();
  List<InventoryModel> inventories = [];

  void getInventories() async {
    inventories = await inventoryData.getInventories();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getInventories();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    inventories.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar.medium(
            centerTitle: true,
            pinned: true,
            title: Text('Inventários'),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
          SliverList.builder(
            itemCount: inventories.length,
            itemBuilder: (context, index) {
              return InventoryWidget(
                title: inventories[index].title,
                buttonOnPressed: () {
                  // inventoryData.removeInventory(inventories[index].title);
                  getInventories();
                  setState(() {});
                },
              );
            },
          ),
        ]
      ),
    );
  }
}