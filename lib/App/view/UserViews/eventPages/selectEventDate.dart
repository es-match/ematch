import 'package:ematch/App/controller/locationController.dart';
import 'package:ematch/App/custom_widgets/userLocationEventtableCalendar.dart';
import 'package:ematch/App/model/eventModel.dart';
import 'package:ematch/App/model/groupModel.dart';
import 'package:ematch/App/model/locationModel.dart';
import 'package:ematch/App/view/UserViews/eventPages/paymentCheckinPage.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:table_calendar/table_calendar.dart';
// import 'package:intl/intl.dart';

class SelectEventDate extends StatefulWidget {
  SelectEventDate({this.location, this.group});

  @override
  _SelectEventDateState createState() => _SelectEventDateState();
  final LocationModel location;
  final GroupModel group;
}

class _SelectEventDateState extends State<SelectEventDate> {
  LatLng geoPosition;
  LocationController locationController = LocationController();
  GoogleMapController googleMapController;
  CalendarController _calendarController = CalendarController();
  Set<Marker> markers = Set();
  DateTime currentDay;

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

      currentDay = DateTime.now().add(Duration(days: 1));
    });
  }

  dynamic getDayEvents(List<dynamic> events, DateTime day) {
    setState(() {
      //LIMPA DROPDOWNS
      startDropdownvalue = null;
      endDropdownvalue = null;
      currentDay = day.subtract(Duration(hours: 12));
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
                ElevatedButton(
                    onPressed:
                        (startDropdownvalue == null || endDropdownvalue == null || currentDay == null)
                            ? null
                            : () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PaymentCheckinPage(
                                          location: widget.location,
                                          eventDay: currentDay,
                                          startHour: startDropdownvalue,
                                          endHour: endDropdownvalue,
                                          group: widget.group)),
                                );
                              },
                    child: Text("Ir para pagamento")),
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
        Text("Início: ",
            style: TextStyle(
              fontSize: 20,
            )),
        DropdownButton(
          dropdownColor: Colors.grey[900],
          value: startDropdownvalue,
          onChanged: (String newValue) {
            setState(() {
              startDropdownvalue = newValue;
              endDropdownvalue = startDropdownvalue;
            });
          },
          items: dropDownMenuItems(),
          style: const TextStyle(color: Colors.white),
        ),
        SizedBox(width:20),
        Text("Fim: ", style: TextStyle(fontSize: 20)),
        DropdownButton(
          dropdownColor: Colors.grey[900],
          value: endDropdownvalue,
          onChanged: (String newValue) {
            setState(() {
              endDropdownvalue = newValue;
            });
          },
          items: dropDownMenuItems(true),
          // .where((element) =>
          //     int.parse(startDropdownvalue ?? "0") <=
          //     int.parse(element.value))
          // .toList(),
          style: const TextStyle(color: Colors.white),
        ),
      ],
    ));
  }

  List<DropdownMenuItem<String>> dropDownMenuItems([bool end = false]) {
    if (end && startDropdownvalue == null) return null;

    var hours = widget.location.avaiableHours.split(',').toList();

    //REMOVE horários cadastrados no dia selecionado
    if (dayEvents != null) {
      if (dayEvents.isNotEmpty) {
        dayEvents.forEach((event) {
          EventModel ev = event;

          // String startTime =
          // //REMOVER .substract ao resolver situacao de regionalizaçao (UTC-3)
          //    (DateFormat("HH").format(DateTime.parse(ev.startDate).subtract(Duration(hours: 3))));
          List<String> alocatedHoursList = ev.getAlocatedHoursList();
          if (alocatedHoursList.isNotEmpty) {
            alocatedHoursList.forEach((e) {
              if (hours.contains(e)) {
                hours.remove(e);
              }
            });
          }
        });
      }
    }

    //REMOVER HORARIOS C/ GAP
    if (end) {
      hours = hours
          .where((element) =>
              (int.parse(element) - int.parse(startDropdownvalue ?? "0")) ==
              (hours.indexOf(element) -
                  hours.indexOf(startDropdownvalue ?? "0")))
          .toList();
    }

    ////REMOVE horários do passado
    // if (currentDay != null && currentDay.day == DateTime.now().day) {
    //   hours = hours
    //       .where((element) => int.parse(element) >= (DateTime.now().hour + 1))
    //       .toList();
    // }

    return hours.map<DropdownMenuItem<String>>((String value) {
      String sufix = end ? "59" : "00";
      return DropdownMenuItem<String>(
        value: value,
        child: Text("$value:$sufix"),
        onTap: () {},
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
            futureEvents:
                locationController.getLocationEvents(widget.location.id),
            customOnDaySelected: getDayEvents),
      ),
    );
  }

  Container buildMap(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        // scrollGesturesEnabled: false,

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
      child: Center(
        child: Text(
          "Valor Por hora: ${widget.location.hourValue}",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
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
