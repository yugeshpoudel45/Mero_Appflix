import 'package:flutter/material.dart';

class HelloPage extends StatelessWidget {
  const HelloPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 2,
              color: Colors.red,
            ),
            const SizedBox(
              height: 800,
              child: TabBar(
                tabs: [
                  Tab(
                    text: 'Tab 1',
                  ),
                  Tab(
                    text: 'Tab 2',
                  ),
                ],
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 800,
                child: TabBarView(
                  children: [
                    // Tab 1 content
                    Container(
                      color: Colors.blue,
                    ),
                    // Tab 2 content
                    Container(
                      color: Colors.green,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
