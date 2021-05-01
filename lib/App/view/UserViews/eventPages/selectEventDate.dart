import 'package:ematch/App/controller/locationController.dart';
import 'package:ematch/App/custom_widgets/userLocationEventtableCalendar.dart';
import 'package:ematch/App/model/eventModel.dart';
import 'package:ematch/App/model/locationModel.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class SelectEventDate extends StatefulWidget {
  
  SelectEventDate({this.location});

  @override
  _SelectEventDateState createState() => _SelectEventDateState();
  final LocationModel location;
}

class _SelectEventDateState extends State<SelectEventDate> {
  LatLng geoPosition;
  LocationController locationController = LocationController();
  GoogleMapController googleMapController;
  CalendarController _calendarController = CalendarController();  
  Set<Marker> markers = Set();
  
  List<dynamic> dayEvents;

  String startDropdownvalue;
  String endDropdownvalue;
  // String dropdownValue = 'One';
  @override
  void initState() {
    super.initState();
    setState(() {
      geoPosition = LatLng(widget.location.geolocation.dLatitude,
          widget.location.geolocation.dLongitude);
      setMarkers();
    });
  }

  dynamic getDayEvents(List<dynamic> events)  {
    setState(() {
      dayEvents = events;
      print(dayEvents);
    });    
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Defina o horário"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildMap(context),
            Divider(),
            buildLocationValues(),
            Divider(),
            buildCalendarTable(context),
            Divider(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildDropdownButtons(),
                ElevatedButton(onPressed: (){}, child: Text("Ir para pagamento")),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container buildDropdownButtons() {
    return Container(
              child: Row(
            children: [
              DropdownButton(
                value: startDropdownvalue,                  
                
                onChanged: (String newValue) {
                  setState(() {
                    startDropdownvalue = newValue;                      
                    endDropdownvalue = startDropdownvalue;
                  });
                },
                items: dropDownMenuItems(),
                style: const TextStyle(
                    color: Colors.white, backgroundColor: Colors.black),
              ),
              DropdownButton(
                value: endDropdownvalue,
                onChanged: (String newValue) {
                  setState(() {
                    endDropdownvalue = startDropdownvalue;
                  });
                },
                items: dropDownMenuItems(true)
                     .where((element) =>
                         int.parse(startDropdownvalue ?? "0")  <=
                         int.parse(element.value))
                     .toList(),                      
                style: const TextStyle(
                    color: Colors.white, backgroundColor: Colors.black),
              ),
            ],
          ));
  }

  List<DropdownMenuItem<String>> dropDownMenuItems([bool end = false]) {
    var hours = widget.location.avaiableHours.split(',').toList();

    //REMOVE horários cadastrados no dia selecionado
    if(dayEvents != null){
    dayEvents.forEach((event) { 
        EventModel ev = event;
        String startTime =
        //REMOVER .substract ao resolver situacao de regionalizaçao (UTC-3)
           (DateFormat("HH").format(DateTime.parse(ev.startDate).subtract(Duration(hours: 3))));

        if(hours.contains(startTime)){
          hours.remove(startTime);
        }        


          
      });
    }



    //REMOVER HORARIOS C/ GAP    
    if (end) {
        hours = hours.where((element) => (int.parse(element) - int.parse(startDropdownvalue ?? "0")) == (hours.indexOf(element) - hours.indexOf(startDropdownvalue ?? "0"))).toList();
    }   

    return hours.map<DropdownMenuItem<String>>((String value) {
      String sufix = end ? "59" : "00";
      return DropdownMenuItem<String>(
        value: value,
        child: Text("$value:$sufix"),
        onTap: (){},
      );
    }).toList();
  }

  Container buildCalendarTable(BuildContext context) {
    return Container(
        // height: MediaQuery.of(context).size.height,
        // width: MediaQuery.of(context).size.width,
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: UserLocationEventtableCalendar(
        futureEvents: locationController.getLocationEvents(widget.location.id),customOnDaySelected: getDayEvents),
            ), 
                );
          }    
        
        
          Container buildMap(BuildContext context) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width,
              child: GoogleMap(
                onCameraMove: (position) => {},
                mapToolbarEnabled: false,
                // zoomControlsEnabled: false,
                zoomGesturesEnabled: false,
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(target: geoPosition, zoom: 14),
                markers: markers,
                onMapCreated: (controller) {
                  googleMapController = controller;
                },
              ),
            );
          }
        
          Container buildLocationValues() {
            return Container(
              child: Text("Valor Por hora: ${widget.location.hourValue}"),
            );
          }
        
          void setMarkers() {
            markers = {};
            //POSICAO DO ESPACO ESPORTIVO
            markers.add(//MARKER PRINCIPAL
                Marker(
              markerId: MarkerId("CURRENTPOSITION"),
              position: geoPosition,
              onTap: () {},
            ));
          }
        
          TableCalendar buildCalendar() {
            return TableCalendar(
              availableCalendarFormats: {
                CalendarFormat.month: 'Mensal',
                CalendarFormat.twoWeeks: '2 Semanas',
                CalendarFormat.week: 'Semanal',
              },
              calendarController: _calendarController,
              locale: 'pt_BR',
            );
          }
        
          
           
}
