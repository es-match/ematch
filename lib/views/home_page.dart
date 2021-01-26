import 'package:flutter/material.dart';

class InnerHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (context, index) => ListTile(
        title: Card(
          child: Stack(
            children: [
              Container(
                height: 100,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(alignment: Alignment.topLeft, child: Text('Text')),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                  child: Icon(Icons.check_box_rounded)),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  WidgetSpan(
                                    child: Icon(Icons.calendar_today),
                                  ),
                                  TextSpan(
                                    text: 'Hoje, das 19:00 - 21:00',
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
