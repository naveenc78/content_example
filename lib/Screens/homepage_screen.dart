import 'package:flutter/material.dart';
import 'package:content_example/Screens/content_display.dart';
import 'package:content_example/Screens/user_profile_disolay.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const memberurl = 'https://www.uscarrom.org/membership-details/';
const donateurl =
    'https://www.paypal.com/donate/?hosted_button_id=9SQ5CST8FTGE6';
const tourneyurl = 'https://www.uscarrom.org/tournament/';

class MyHomePage extends StatefulWidget {
  const MyHomePage(
      {Key? key,
      required this.title,
      required this.tab,
      required this.pparam,
      required this.data})
      : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  final String tab;
  final String pparam;
  final Object? data;

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

// this is a public class so the global key can be accessed from outside
class MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  static const List<Tab> contentTabs = <Tab>[
    Tab(text: 'Pavilion', icon: Icon(Icons.home)),
    Tab(text: 'Buzz', icon: Icon(Icons.network_wifi_sharp)),
    Tab(text: 'Champions', icon: Icon(Icons.leaderboard)),
    Tab(text: 'Blogs', icon: Icon(Icons.article)),
    Tab(text: 'Sponsors', icon: Icon(Icons.money)),
  ];

  // this is the mapping from display name to storage folders
  static const Map<String, String> storagerefmap = {
    "Pavilion": "Pavilion",
    "Buzz": "News",
    "Champions": "Rankings",
    "Blogs": "Blogs",
    "Sponsors": "Sponsors"
  };

  late TabController _tabController;
  int initialselection = 0;

  // this is the tab status bar
  TabBar get _tabBar => TabBar(
        controller: _tabController,
        tabs: contentTabs,
        indicatorColor: Colors.black,
        labelPadding: const EdgeInsets.symmetric(horizontal: 50.0),
        isScrollable: (MediaQuery.of(context).size.width <= 600) ? true : false,
        labelStyle: Theme.of(context).tabBarTheme.labelStyle,
      );

  String getStorageReference(int index) {
    if (storagerefmap[contentTabs[index].text!] == null) {
      return "USCA";
    }
    return "USCA/" + storagerefmap[contentTabs[index].text!]!;
  }

  // set up initState and dispose of the stateful widget, retrieving the provider and listening to changes
  @override
  void initState() {
    int index = 0;
    if (widget.tab.isNotEmpty) {
      index = contentTabs.indexWhere((tab) => tab.text!.contains(widget.tab));
    }

    _tabController = TabController(
        vsync: this, length: contentTabs.length, initialIndex: index);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        elevation: 10, // color of app bar
        toolbarHeight: height * 0.1,
        leadingWidth: width * 0.15,
        // lead with the logo, if you need a menu bar, this can be moved to title
        leading: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Image.asset(
            "assets/images/logo.png",
          ),
        ),

        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title,
            style: TextStyle(
                fontSize: (width <= 600) ? 15 : 20,
                fontFamily: 'Open Sans',
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.normal)),

        centerTitle: true,
        // leading: const Icon(Icons.menu),
        actions: buildactions(context),
        bottom: PreferredSize(
          preferredSize: _tabBar.preferredSize,
          child: ColoredBox(
            color: Theme.of(context).bottomAppBarColor,
            child: _tabBar,
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ContentDisplay(title: getStorageReference(0), itemID: widget.pparam),
          ContentDisplay(title: getStorageReference(1), itemID: widget.pparam),
          ContentDisplay(title: getStorageReference(2), itemID: widget.pparam),
          ContentDisplay(title: getStorageReference(3), itemID: widget.pparam),
          ContentDisplay(title: getStorageReference(4), itemID: widget.pparam),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        shape: const CircularNotchedRectangle(),
        child: buildBottomBar(context),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _launchURL(url: tourneyurl);
        },
        tooltip: 'Play With / Follow Us',
        child: const Icon(Icons.play_circle_fill),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation
          .centerDocked, // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  // method to build the bottom nav bar
  Widget buildBottomBar(context) {
    return Container(
      height: 50,
      child: Row(
        children: <Widget>[
          const Spacer(),
          Tooltip(
            message: 'Become a USCA Member',
            child: ElevatedButton.icon(
                icon: const Icon(Icons.wallet_membership_outlined),
                style: ElevatedButton.styleFrom(
                    elevation: 10.0,
                    primary: Colors.red,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.sp))),
                onPressed: () {
                  _launchURL(url: memberurl);
                },
                label: const Text('Join Us', style: TextStyle(fontSize: 14.0))),
          ),
          const Spacer(),
          (MediaQuery.of(context).size.width >= 600)
              ? const Text('\n\n@Copyright USCA 2022. Powered by @SportsClubs',
                  style: TextStyle(fontSize: 9.0))
              : const Text(''),
          const Spacer(),
          Tooltip(
            message: 'Give to the sport you love in just a click. Thank you!',
            child: ElevatedButton.icon(
                icon: const Icon(Icons.money_rounded),
                style: ElevatedButton.styleFrom(
                    elevation: 10.0,
                    primary: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                onPressed: () {
                  _launchURL(url: donateurl);
                },
                label: const Text('Donate', style: TextStyle(fontSize: 14.0))),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  //the title widget with logo, title and sub title
  Widget buildtitle(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            //uncomment bottom two widgets if logo is part of title not leading
            //const SizedBox(width: 5.0),
            // Container(
            //     width: 150.0,
            //     height: 400.0,
            //     decoration: const BoxDecoration(
            //         shape: BoxShape.rectangle,
            //         image: DecorationImage(
            //             fit: BoxFit.fitWidth,
            //             image: AssetImage('assets/images/logo.png')))),
            SizedBox(width: 10.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 5.h),
                Text(widget.title,
                    style: TextStyle(
                        fontSize: 25.sp,
                        fontFamily: 'Open Sans',
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.normal)),
                SizedBox(height: 2.h),
                Text('                   where Passion meets Perfection',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14.sp,
                        fontStyle: FontStyle.italic)),
              ],
            ),
          ],
        ),
      ],
    );
  }

  //build actions widgets on the title bar
  List<Widget>? buildactions(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return <Widget>[
      // user profile actions
      UserProfileDisplay(),
      (MediaQuery.of(context).size.width <= 600)
          ? const SizedBox(width: 5)
          : const SizedBox(width: 15),
      GestureDetector(
        child: Transform.scale(scale: 1.25, child: const Icon(Icons.menu)),
        onTapDown: (details) => showPopUpMenuAtTap(context, details),
      ),
      (MediaQuery.of(context).size.width <= 600)
          ? const SizedBox(width: 5)
          : const SizedBox(width: 15),
    ];
  }

  void showPopUpMenuAtTap(BuildContext context, TapDownDetails details) {
    showMenu<String>(
      context: context,
      color: Colors.orange[200],
      position: RelativeRect.fromLTRB(
        details.globalPosition.dx,
        details.globalPosition.dy,
        details.globalPosition.dx,
        details.globalPosition.dy,
      ),
      items: [
        const PopupMenuItem<String>(
            enabled: false,
            mouseCursor: MouseCursor.defer,
            child: Text('Tournaments - Coming Soon',
                style: TextStyle(fontStyle: FontStyle.italic)),
            value: 'tournaments'),
        const PopupMenuItem<String>(
            enabled: false,
            child: Text('Chapters - Coming Soon',
                style: TextStyle(fontStyle: FontStyle.italic)),
            value: 'chapters'),
        const PopupMenuItem<String>(
            enabled: false,
            child: Text('Membership - Coming Soon',
                style: TextStyle(fontStyle: FontStyle.italic)),
            value: 'membership'),
      ],
      elevation: 8.0,
    );
  }

// Launch URL
  void _launchURL({required String url, bool newTab = true}) async {
    await launch(url, webOnlyWindowName: (newTab == true) ? null : '_self');
  }
}
