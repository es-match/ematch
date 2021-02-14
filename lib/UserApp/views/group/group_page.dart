import 'package:ematch/UserApp/views/group/newGroup_page.dart';
import 'package:flutter/material.dart';
import 'package:simple_search_bar/simple_search_bar.dart';

class GroupPage extends StatefulWidget {
  @override
  _GroupPageState createState() => _GroupPageState();
}

final AppBarController appBarController = AppBarController();

class _GroupPageState extends State<GroupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchAppBar(
        primary: Theme.of(context).primaryColor,
        appBarController: appBarController,
        // You could load the bar with search already active
        autoSelected: false,
        searchHint: "Pesquisar Grupo",
        mainTextColor: Colors.white,
        onChange: (String value) {
          //Your function to filter list. It should interact with
          //the Stream that generate the final list
        },
        //Will show when SEARCH MODE wasn't active
        mainAppBar: AppBar(
          title: Text("Meus Grupos"),
          actions: <Widget>[
            InkWell(
              child: Icon(
                Icons.search,
              ),
              onTap: () {
                //This is where You change to SEARCH MODE. To hide, just
                //add FALSE as value on the stream
                appBarController.stream.add(true);
              },
            ),
          ],
        ),
      ),
      body: Column(children: []),
      bottomNavigationBar: RaisedButton(
        child: Text('Criar um Grupo'),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NewGroupPage()),
        ),
      ),
    );
  }
}

// class _GroupPageState extends State<GroupPage> {
//   List<int> offDays = [1, 2, 3, 4, 5, 30, 24, 27, 29];

//   final List<Widget> formWidgets = <Widget>[
//     Card(
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             Text('Nome do Evento'),
//             Divider(),
//             TextFormField(
//               decoration: InputDecoration(labelText: 'Nome do Evento'),
//             ),
//           ],
//         ),
//       ),
//     ),
//     Card(
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             Text('Data do Evento'),
//             Divider(),
//             DropdownButton(
//               onChanged: (value) {},
//               items: ['AJB', 'FutBar', 'ematchArena'].map(
//                 (e) {
//                   return DropdownMenuItem(
//                     child: Text(e),
//                   );
//                 },
//               ).toList(),
//             ),
//             CalendarDatePicker(
//                 selectableDayPredicate: (date) {
//                   return [1, 2, 3, 4, 5, 3, 24, 27, 29].contains(date.day)
//                       ? true
//                       : false;
//                 },
//                 initialDate: DateTime(2021, 1, 1),
//                 firstDate: DateTime(2021),
//                 lastDate: DateTime(2022),
//                 onDateChanged: (value) {})
//           ],
//         ),
//       ),
//     ),
//     Card(
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             Text('Local do Event2o'),
//             Divider(),
//             DropdownButton(
//               onChanged: (value) {},
//               items: ['AJB', 'FutBar', 'ematchArena'].map(
//                 (e) {
//                   return DropdownMenuItem(
//                     child: Text(e),
//                   );
//                 },
//               ).toList(),
//             ),
//             CalendarDatePicker(
//                 selectableDayPredicate: (date) {
//                   return [1, 2, 3, 4, 5, 3, 24, 27, 29].contains(date.day)
//                       ? true
//                       : false;
//                 },
//                 initialDate: DateTime(2021, 1, 1),
//                 firstDate: DateTime(2021),
//                 lastDate: DateTime(2022),
//                 onDateChanged: (value) {
//                   // showModalBottomSheet(context, builder) {}
//                 })
//           ],
//         ),
//       ),
//     ),
//     Card(
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [],
//         ),
//       ),
//     ),
//   ];

//   buildForm({context, index}) {
//     return ListTile(
//       title: formWidgets[index],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: formWidgets.length,
//       itemBuilder: (context, index) =>
//           buildForm(context: context, index: index),
//     );
//   }
// }
