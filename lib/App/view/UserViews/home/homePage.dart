import 'package:ematch/App/controller/eventController.dart';
import 'package:ematch/App/controller/sign_in.dart';
import 'package:ematch/App/custom_widgets/eventCard.dart';
import 'package:ematch/App/custom_widgets/eventList.dart';
// ignore: unused_import
import 'package:ematch/App/custom_widgets/groupList.dart';
import 'package:ematch/App/model/eventModel.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ematch/App/view/UserViews/eventPages/eventDetailPage.dart';

class HomePage extends StatefulWidget {
  final String name;
  final String userID;
  final changeIndexFunction;

  HomePage({this.name, this.userID, this.changeIndexFunction});

  @override
  _HomePageState createState() => _HomePageState();
}

List<EventModel> _eventList = [];

class _HomePageState extends State<HomePage> {
  final List<Widget> listBuilderItems = [EventList(), EventList()];
  Future<List<EventModel>> future;
  EventController _controller = EventController();

  @override
  void initState() {
    super.initState();
    future = _controller.getEventsByUserID(myUserid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
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
            CircleAvatar(
              backgroundImage: NetworkImage(myImageurl),
            ),
          ],
        ),
      )),
      body: FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            _eventList = snapshot.data;
            return buildBody();
          } else
            return Center(child: CircularProgressIndicator());
        },
      ),
      bottomNavigationBar: buildBottomButtons(context),
    );
  }

  dynamic buildBody() {
    if (_eventList == null) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
          alignment: Alignment.center,
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: "Sem eventos atuais :(\nQue tal montar em ",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                wordSpacing: 5,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: 'seus grupos',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                  recognizer: new TapGestureRecognizer()
                    ..onTap = () {
                      widget.changeIndexFunction(2);
                    },
                ),
                TextSpan(
                  text: ' o próprio evento ou procurar em ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                TextSpan(
                  text: 'outros grupos?',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                  recognizer: new TapGestureRecognizer()
                    ..onTap = () {
                      widget.changeIndexFunction(1);
                    },
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _eventList.length,
              itemBuilder: (context, index) => ListTile(
                title: InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EventDetailPage(model: _eventList[index]),
                    ),
                  ),
                  child: EventCard(event: _eventList[index]),
                ),
              ),
            ),
          ),
        ],
      );
    }
  }

  Padding buildBottomButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height / 13,
              width: MediaQuery.of(context).size.width / 2.5,
              child: ElevatedButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(Icons.search),
                      Text(
                        'Buscar Grupos',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  onPressed: () {
                    widget.changeIndexFunction(1);
                  }),
            ),
          ),
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height / 13,
              width: MediaQuery.of(context).size.width / 2.5,
              child: ElevatedButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(Icons.people),
                    Text(
                      'Meus Grupos',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                onPressed: () {
                  // controller.setScreenIndex(3);
                  setState(() {
                    widget.changeIndexFunction(2);
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
