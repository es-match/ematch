import 'package:ematch/App/custom_widgets/groupCard.dart';
import 'package:flutter/material.dart';

class GroupList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 4,
      itemBuilder: (context, index) => ListTile(
        // title: GroupCard(),
        title: GroupCard(),
      ),
    );
  }
}
