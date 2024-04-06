import 'package:flutter/material.dart';

class Practice extends StatelessWidget {
  const Practice({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        // backgroundColor: Colors.grey,
        body: CustomScrollView(
          slivers: <Widget>[
            // SliverAppBar(
            //   automaticallyImplyLeading: false,
            //   backgroundColor: Colors.white,
            //   pinned: false,
            //   floating: true,
            //   snap: true,
            //   // toolbarHeight: double.minPositive,
            //   flexibleSpace: FlexibleSpaceBar(
            //     background: Container(
            //       color: Colors.blue,
            //     ),
            //     titlePadding: const EdgeInsets.all(0),
            //     title: const Text(
            //       'Demo',
            //       style: TextStyle(color: Colors.black),
            //     ),
            //   ),
            // ),
            const SliverAppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              pinned: true,
              floating: true,
              snap: true,
              // toolbarHeight: double.minPositive,
              // title: Text(
              //   'Demo',
              //   style: TextStyle(color: Colors.black),
              // ),
              bottom: TabBar(
                tabs: [
                  Tab(text: 'Tab 1'),
                  Tab(text: 'Tab 2'),
                  Tab(text: 'Tab 3'),
                ],
              ),
            ),
            SliverFillRemaining(
              child: TabBarView(
                children: [
                  const SingleChildScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        Text(
                          "Welcome to the World",
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text('Login'),
                    ),
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text('Login'),
                    ),
                  ),
                ],
              ),
            ),
            // SliverList(
            //   delegate: SliverChildBuilderDelegate(
            //     (BuildContext context, int index) {
            //       return Container(
            //         color: index.isEven ? Colors.white : Colors.grey,
            //         height: 100.0,
            //         child: Center(
            //           child: Text('Item $index'),
            //         ),
            //       );
            //     },
            //     childCount: 10,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
