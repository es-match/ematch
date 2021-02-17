import 'package:ematch/OwnerApp/views/mainPage/model/locationModel.dart';
import 'package:ematch/OwnerApp/views/mainPage/repository/locationRepository.dart';
import 'package:flutter/material.dart';

LocationRepository repository = LocationRepository();
Future<List<LocationModel>> model = repository.getLocations();

class OverViewPage extends StatefulWidget {
  @override
  _OverViewPageState createState() => _OverViewPageState();
}

class _OverViewPageState extends State<OverViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("OverviewPage"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: FutureBuilder(
            future: model,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done)
                return buildLocationColumn(snapshot.data);
              else
                return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }

  Column buildLocationColumn(List<LocationModel> locationsList) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 6,
          child: ListView.builder(
            itemCount: locationsList.length,
            itemBuilder: (context, index) {
              String title = locationsList[index].locationName;
              return ListTile(
                title: Card(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),
                    height: 100,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: ClipOval(
                                child: Container(
                                  decoration: BoxDecoration(color: Colors.red),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(title),
                                  Chip(label: Text("CHIP TEST"))
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: RaisedButton(
            onPressed: () => print("x"),
            child: Text("Adicionar Novo Local"),
          ),
        ),
      ],
    );
  }
}
