import "package:flutter/material.dart";

class MessageBox extends StatefulWidget {
  const MessageBox({super.key});

  @override
  State<MessageBox> createState() => _MessageBoxState();
}

class _MessageBoxState extends State<MessageBox> {
  @override
  Widget build(BuildContext context) {
    const upperTab = TabBar(
        indicatorColor: Color.fromARGB(255, 235, 227, 0),
        indicatorWeight: 6,
        tabs: <Tab>[
          Tab(
            child: Text('News',
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w500)),
          ),
          Tab(
            child: Text('Notification',
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w500)),
          ),
        ]);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Row(
              mainAxisSize: MainAxisSize.min,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const Text('Message Box',
                    style: TextStyle(
                        fontSize: 21.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w600)),
              ],
            ),
            excludeHeaderSemantics: true,
            backgroundColor: Colors.grey[50],
            elevation: 3,
            bottom: upperTab,
            iconTheme: const IconThemeData(color: Colors.black)),
        body:  TabBarView(
          children: [
            Center(
              child:  Image.asset(
                'assets/undraw_mailbox_re_dvds.png',
                height: MediaQuery.of(context).size.height * .25,
              ),
            ),
           Center(
              child: Image.asset(
                'assets/undraw_mailbox_re_dvds.png',
                height: MediaQuery.of(context).size.height * .25,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
