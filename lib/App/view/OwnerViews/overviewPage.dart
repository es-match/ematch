import 'dart:math';

import 'package:ematch/App/controller/sign_in.dart';
import 'package:ematch/App/model/locationModel.dart';
import 'package:ematch/App/repository/locationRepository.dart';
import 'package:ematch/App/view/OwnerViews/locationPage/editLocationPage.dart';
import 'package:ematch/App/view/OwnerViews/locationPage/insertLocationPage.dart';
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
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.refresh),
        //     onPressed: () {
        //       model = repository.getLocations();
        //       setState(() {});
        //     },
        //   )
        // ],
        title: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/esmatch_logo_white_draw.png',
                    height: 50,
                  ),
                  Text(
                    'Easy Sport Match',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Align(
                child: CircleAvatar(
                  backgroundImage: NetworkImage(myImageurl),
                ),
              ),
            ],
          ),
        ),
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.refresh),
        //     onPressed: () {
        //       model = repository.getLocations();
        //       setState(() {});
        //     },
        //   )
        // ],
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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 4.0),
        child: Container(
          height: MediaQuery.of(context).size.height / 12,
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => InsertLocationPage(),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add,
                  size: 50,
                ),
                Text(
                  " Adicionar Novo Local",
                  style: TextStyle(fontSize: 27),
                ),
              ],
            ),
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
            itemCount: locationsList == null ? 0 : locationsList.length,
            itemBuilder: (context, index) {
              LocationModel currLocation = locationsList[index];
              // ignore: unused_local_variable
              String title = locationsList[index].locationName;
              return ListTile(
                title: InkWell(
                    onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditLocationPage(
                              locationModel: locationsList[index],
                            ),
                          ),
                        ),
                    child: Card(
                      child: Stack(
                        children: [
                          Container(
                            height: 100,
                            width: MediaQuery.of(context).size.width,
                            child: Image.network(
                              currLocation.imageUrl,
                              fit: BoxFit.none,
                            ),
                          ),
                          Container(
                            height: 100,
                            width: MediaQuery.of(context).size.width,
                            color: Color.fromRGBO(5, 5, 5, 0.65),
                          ),
                          Container(
                            height: 100,
                            child: Stack(children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      currLocation.locationName,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Text(
                                      "Agendamentos finalizados: ${Random().nextInt(30)}",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ),
                              // Icon(
                              //   Icons.login,
                              //   color: Colors.white,
                              //   size: 20.0,
                              //   semanticLabel: 'Crie uma nova conta',
                              // ),
                              // Align(
                              //   alignment: Alignment.topRight,
                              //   child: Text(
                              //     'activityName',
                              //     style: TextStyle(
                              //         color: Colors.white,
                              //         fontStyle: FontStyle.italic),
                              //   ),
                              // )
                            ]),
                          ),
                        ],
                      ),
                    )
                    // Card(
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //       border: Border.all(color: Colors.black),
                    //     ),
                    //     height: 100,
                    //     child: Padding(
                    //       padding: const EdgeInsets.all(8.0),
                    //       child: Row(
                    //         children: [
                    //           Expanded(
                    //             flex: 1,
                    //             child: Padding(
                    //               padding: const EdgeInsets.all(2.0),
                    //               child: ClipOval(
                    //                 child: currLocation.imageUrl != null
                    //                     ? Image.network(currLocation.imageUrl)
                    //                     : Container(
                    //                         decoration:
                    //                             BoxDecoration(color: Colors.red),
                    //                       ),
                    //               ),
                    //             ),
                    //           ),
                    //           Expanded(
                    //             flex: 3,
                    //             child: Padding(
                    //               padding: const EdgeInsets.all(8.0),
                    //               child: Column(
                    //                 children: [
                    //                   Text(title),
                    //                   Chip(label: Text("CHIP TEST"))
                    //                 ],
                    //               ),
                    //             ),
                    //           )
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    ),
              );
            },
          ),
        ),
      ],
    );
  }
}
