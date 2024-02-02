import 'package:flutter/material.dart';

class HelloPage extends StatefulWidget {
  const HelloPage({super.key});

  @override
  State<HelloPage> createState() => _HelloPageState();
}

class _HelloPageState extends State<HelloPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              const SliverAppBar(
                title: Text('Tabs Demo'),
                pinned: true,
                floating: true,
                bottom: TabBar(
                  isScrollable: true,
                  tabs: [
                    Tab(child: Text('Flight')),
                    Tab(child: Text('Train')),
                    Tab(child: Text('Car')),
                    Tab(child: Text('Cycle')),
                    Tab(child: Text('Boat')),
                  ],
                ),
              ),
            ];
          },
          body: const TabBarView(
            children: <Widget>[
              Icon(Icons.flight, size: 350),
              Icon(Icons.directions_transit, size: 350),
              Icon(Icons.directions_car, size: 350),
              Icon(Icons.directions_bike, size: 350),
              Icon(Icons.directions_boat, size: 350),
            ],
          ),
        ),
      ),
    );

    // Container(
    //   height: MediaQuery.of(context).size.height / 2,
    //   color: Colors.red,
    // ),
    // const TabBar(
    //   tabs: [
    //     Tab(
    //       text: 'Tab 1',
    //     ),
    //     Tab(
    //       text: 'Tab 2',
    //     ),
    //   ],
    // ),
    // SizedBox(
    //   height: MediaQuery.of(context).size.height,
    //   child: TabBarView(
    //     children: [
    //       // Tab 1 content
    //       Container(
    //         color: Colors.blue,
    //       ),
    //       // Tab 2 content
    //       Container(
    //         color: Colors.green,
    //       ),
    //     ],
    //   ),
    // ),
  }
}
