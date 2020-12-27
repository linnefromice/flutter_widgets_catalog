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
  final List<Widget> views = <Widget>[
    Center(
      child: Text(
        "View One",
        style: TextStyle(
          color: Colors.red[200]
        ),
      ),
    ),
    Center(
      child: Text(
        "View Two",
        style: TextStyle(
            color: Colors.red[400]
        ),
      ),
    ),
    Center(
      child: Text(
        "View Three",
        style: TextStyle(
            color: Colors.red[600]
        ),
      ),
    ),
    Center(
      child: Text(
        "View Four",
        style: TextStyle(
            color: Colors.red[800]
        ),
      ),
    ),
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
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.blue,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorWeight: 2,
          indicatorPadding: EdgeInsets.symmetric(horizontal: 18.0,
              vertical: 8),
          labelColor: Colors.black,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: views,
      ),
    );
  }
}