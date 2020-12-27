import 'package:flutter/material.dart';

class TabBarViewScreen extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<TabBarViewScreen> with SingleTickerProviderStateMixin {
  final List<Tab> tabs = <Tab>[
    Tab(text: 'One'),
    Tab(text: "Two"),
    Tab(text: "Three"),
    Tab(text: "Four")
  ];
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          tabs: tabs,
          controller: _tabController,
        ),
      ),
    );
  }
}