import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  _launchURL() async {
    Uri _url = Uri.parse('https://www.jrtisistemas.com.br');

    if (await launchUrl(_url)) {
      await launchUrl(_url);
      return;
    } else {
      throw 'Cold not launch $_url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 50, 58, 69),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/JRTi_white_logo.png'),
              // Text('JRTi Sistemas', style: TextStyle(color: Colors.white)),
              const SizedBox(height: 30),
              const Text(
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
                '''      A origem da empresa se deu na década de 1980, através de trabalhos de consultoria e projetos de informática em empresas de grande porte.

      Com o advento das redes de microcomputadores, foi criada a Junqueira e Rodrigues Informática, com soluções integradas e sistemas completos para suprir o grande mercado que se iniciava, o de redes locais para empresas de pequeno e médio porte.''',
              ),
              const SizedBox(height: 30),
              const Text(
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600
                ),
                'Contato  (16) 3713-0900',
              ),
              const SizedBox(height: 30),
              InkWell(
                onTap: _launchURL,
                child: Text(
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.blue.shade400,
                    decorationColor: Colors.blue.shade400,
                  ),
                  'www.jrtisistemas.com.br',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}