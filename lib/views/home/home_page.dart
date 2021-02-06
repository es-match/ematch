import 'package:ematch/custom_widgets/eventList.dart';
import 'package:ematch/custom_widgets/groupList.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final List<Widget> listBuilderItems = [EventList(), EventList()];
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    // return ListView.builder(
    //   itemCount: listBuilderItems.length,
    //   itemBuilder: (context, index) {
    //     return EventList();
    //   },
    // );

    return Column(mainAxisSize: MainAxisSize.min, children: [
      Flexible(
        flex: 7,
        child: EventList(),
      ),
      Flexible(
        flex: 3,
        child: Container(width: _width, child: GroupList()),
      )
    ]);
  }
}
