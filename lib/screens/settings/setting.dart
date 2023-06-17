import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moon_walker/screens/contatants/const.dart';
import 'package:moon_walker/screens/dark_mode/theme.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    //Switch theme
    final themeModel = Provider.of<ThemeModel>(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title:const Text('Settings'),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(musicImages.instance.scaffBackImg),
              fit: BoxFit.cover,
              opacity: 230),
          gradient: LinearGradient(
              colors: ScafBack,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Container(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .02,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                         const Padding(
                            padding:  EdgeInsets.only(left: 16.0),
                            child: Icon(Icons.brush),
                          ),
                         const Padding(
                            padding:  EdgeInsets.only(left: 28.0),
                            child: Text('Theme'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 150.0),
                            child: Switch(
                              value: themeModel.currentThemeMode ==
                                  ThemeModeType.dark,
                              onChanged: (_) => themeModel.toggleTheme(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .02,
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: AboutListTile(
                      icon:const Icon(Icons.info),
                      applicationName: 'Music Player',
                      applicationVersion: '1.2.0',
                      applicationIcon: Container(
                          width: 50,
                          height: 50,
                          child: Image.asset(
                            'assets/images/music.png',
                            fit: BoxFit.cover,
                          )),
                      applicationLegalese: '© 2023 Music Player Inc.',
                      aboutBoxChildren:const [
                        Text('Welcome to the Music Player App!'),
                        Text('Enjoy your favorite music anytime, anywhere.'),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .02,
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child:const ListTile(
                      leading: Icon(
                        Icons.share_sharp,
                      ),
                      title: Text('Share app'),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .02,
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: InkWell(
                      onTap: () {
                        settingslistTile(context, 'Terms and conditions',
                            "1. Acceptance of Terms: \nBy accessing or using the music app, you agree to be bound by these terms and By accessing or using the music app, you agree to be bound by these terms .\n\n2. Use of the App:\nYou may use the app for personal, non-commercial purposes only. You are prohibited from modifying, copying, distributing, transmitting, displaying, performing, reproducing, publishing, licensing, creating derivative works from, transferring, or selling any information, software, products, or services obtained from the app.");
                      },
                      child:const ListTile(
                        leading: Icon(
                          Icons.flag_circle,
                        ),
                        title: Text('Terms and conditions'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .02,
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: InkWell(
                      onTap: () {
                        settingslistTile(context, 'Privacy policy',
                        "1. Improve our App: \nWe analyze usage data to improve the performance, features, and content of our app.\n\n2. Device Information:\nWe may collect information about your device, such as device Storage, operating system version, and unique device identifiers");
                      },
                      child:const ListTile(
                        leading: Icon(
                          Icons.privacy_tip_rounded,
                        ),
                        title: Text('Privacy Policy'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .02,
                  ),
                 const Align(
                    alignment: Alignment.bottomCenter,
                    child: Text('Version 1.2.0'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

settingslistTile(BuildContext context, String heading, String content) {
  return showDialog(
    context: context,
    builder: (ctx) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor:const Color.fromARGB(255, 201, 183, 204),
        title: Text(heading),
        content: Text(
          content,
          style:const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        actions: [
          CupertinoButton(
            color:const Color.fromARGB(255, 178, 140, 186),
            child:const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
