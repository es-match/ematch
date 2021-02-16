import 'package:flutter/material.dart';

class RevenuePage extends StatefulWidget {
  @override
  _RevenuePageState createState() => _RevenuePageState();
}

class _RevenuePageState extends State<RevenuePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("RevenuePage"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Table(
          border: TableBorder.all(
              color: Colors.black, width: 1, style: BorderStyle.solid),
          children: [
            TableRow(
              children: [
                Text(
                  "Empresa",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Aplicativo",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Manual",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            TableRow(
              children: [
                Text(
                  "PaintBall World",
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  "R\$900(10 loc)",
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  "31/Dec/2020",
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            TableRow(
              children: [
                Text(
                  "Total Esperado",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "R\$900",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(""),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
