import 'package:flutter/material.dart';
import 'package:flutter_auth_ui/flutter_auth_ui.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProfileDisplay extends StatefulWidget {
  UserProfileDisplay({Key? key}) : super(key: key);

  @override
  _UserProfileDisplayState createState() => _UserProfileDisplayState();
}

class _UserProfileDisplayState extends State<UserProfileDisplay> {
  bool _userloggedin =
      (FirebaseAuth.instance.currentUser == null) ? false : true;

  static const authProviders = [AuthUiProvider.google, AuthUiProvider.facebook];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return (!_userloggedin)
        ? Transform.scale(
            scale: 1.25,
            child: IconButton(
              icon: const Icon(Icons.account_box_outlined),
              onPressed: () async {
                final result = await FlutterAuthUi.startUi(
                  items: authProviders,
                  tosAndPrivacyPolicy: TosAndPrivacyPolicy(
                    tosUrl: "https://www.uscarrom.org",
                    privacyPolicyUrl: "https://www.uscarrom.org",
                  ),
                );
                if (result.toString() == "true") {
                  setState(() {
                    _userloggedin = result;
                  });
                }
              },
            ),
          )
        : GestureDetector(
            child: Container(
              child: Row(
                children: <Widget>[
                  //Icon first
                  (FirebaseAuth.instance.currentUser!.photoURL == null)
                      ? const Icon(Icons.account_box_rounded)
                      : CircleAvatar(
                          backgroundImage: NetworkImage(
                              FirebaseAuth.instance.currentUser!.photoURL!),
                          backgroundColor: Colors.red,
                        ),
                  // label
                  const SizedBox(width: 5.0),
                  (FirebaseAuth.instance.currentUser!.displayName == null)
                      ? const Text('')
                      : (width <= 600)
                          ? const Text('')
                          : Container(
                              width: (width * 0.1 > 80) ? 80 : width * 0.1,
                              height: kToolbarHeight * 0.9,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                    "Hi, ${getFirstName(FirebaseAuth.instance.currentUser!.displayName!)}",
                                    style: const TextStyle(
                                        fontSize: 14.0,
                                        fontFamily: 'Open Sans',
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.normal,
                                        color: Colors.white),
                                    maxLines: 2,
                                    textAlign: TextAlign.left),
                              ),
                            ),
                ],
              ),
            ),
            onTapDown: (details) => showProfileMenuAtTap(context, details),
          );
  }

  void showProfileMenuAtTap(
      BuildContext context, TapDownDetails details) async {
    final selected = await showMenu<String>(
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
            mouseCursor: MouseCursor.uncontrolled,
            child: Text('Be a Member',
                style: TextStyle(fontStyle: FontStyle.italic)),
            value: 'member'),
        const PopupMenuItem<String>(
            enabled: false,
            child: Text('Register for an Event',
                style: TextStyle(fontStyle: FontStyle.italic)),
            value: 'register'),
        const PopupMenuDivider(height: 3.0),
        const PopupMenuItem<String>(
            enabled: true,
            child:
                Text('Signout', style: TextStyle(fontWeight: FontWeight.bold)),
            value: 'signout'),
      ],
      elevation: 8.0,
    );

    if (selected == 'signout') {
      await FlutterAuthUi.signOut();
      setState(() {
        _userloggedin = false;
      });
    }
  }

  String getFirstName(String sFullName) {
    return sFullName.split(' ')[0];
  }
}
