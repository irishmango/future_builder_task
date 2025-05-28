import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _textController = TextEditingController();

  Future<String>? _textFuture;




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              spacing: 32,
              children: [
                TextFormField(
                  controller: _textController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Postleitzahl",
                  ),
                ),
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      _textFuture = getCityFromZip(_textController.text);
                    });
                  },
                  child: const Text("Suche"),
                ),
                FutureBuilder(
                  future: _textFuture, 
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator(); 
                    } else if (snapshot.hasError) {
                      return const Text('Error'); 
                    } else if (snapshot.hasData) {
                      return Text("Ergebnis: ${snapshot.data}",
                        style: Theme.of(context).textTheme.labelLarge,
                      ); 
                    } else {
                      return Text("Ergebnis: Noch keine PLZ gesucht",
                        style: Theme.of(context).textTheme.labelLarge,
                      );
                    }
                  },),
                
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Future<String> getCityFromZip(String zip) async {
    // simuliere Dauer der Datenbank-Anfrage
    await Future.delayed(const Duration(seconds: 3));

    switch (zip) {
      case "10115":
        return 'Berlin';
      case "20095":
        return 'Hamburg';
      case "80331":
        return 'München';
      case "50667":
        return 'Köln';
      case "60311":
      case "60313":
        return 'Frankfurt am Main';
      default:
        return 'Unbekannte Stadt';
    }
  }
}
