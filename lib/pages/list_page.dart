import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
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
          SliverToBoxAdapter(
            child: Container(height: 900, color: Colors.blueGrey[100])
          )
        ]
      ),
    );
  }
}