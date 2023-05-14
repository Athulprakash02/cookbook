import 'package:cookbook/db/functions/recently_viewed_functions.dart';
import 'package:cookbook/db/model/recipies.dart';
import 'package:cookbook/widgets/recent_card.dart';
import 'package:flutter/material.dart';

class RecentsScreen extends StatefulWidget {
  const RecentsScreen({super.key});

  @override
  State<RecentsScreen> createState() => _RecentsScreenState();
}

class _RecentsScreenState extends State<RecentsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllRecents();
  }

  @override
  Widget build(BuildContext context) {
    List<Recipes> recent = recently.toSet().toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recently viewed'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return recentCard(recent[index], context, index);
          },
          itemCount: 10,
        ),
      ),
    );
  }
}
