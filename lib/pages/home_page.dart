import 'package:flutter/material.dart';
import './inventory_page.dart';
import './list_page.dart';
import './about_us_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int paginaAtual = 1;
  late PageController pc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    pc = PageController(initialPage: paginaAtual);
  }

  setPaginaAtual(pagina) {
    setState(() => paginaAtual = pagina);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pc,
        onPageChanged: setPaginaAtual,
        children: const [
          AboutUsPage(),
          InventoryPage(),
          ListPage(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: paginaAtual,
        onDestinationSelected: (index) => setState(() {
          paginaAtual = index;
          pc.animateToPage(
            paginaAtual,
            duration: const Duration(milliseconds: 400),
            curve: Curves.ease,
          );
        }),
        animationDuration: const Duration(milliseconds: 400),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.info_outline),
            selectedIcon: Icon(Icons.info),
            label: "Sobre Nós"
          ),
          NavigationDestination(
            icon: Icon(Icons.camera_alt_outlined),
            selectedIcon: Icon(Icons.camera_alt),
            label: "Criar",
          ),
          NavigationDestination(
            icon: Icon(Icons.edit_outlined),
            selectedIcon: Icon(Icons.edit),
            label: "Coletas",
          ),
        ],
      ),
    );
  }
}