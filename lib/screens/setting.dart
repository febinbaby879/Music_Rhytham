import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moon_walker/screens/theme.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _lights = false;
  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<ThemeModel>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              child: Column(
                children: [
                  Container(
                    child: Row(
                      children: [
                        Text(
                          'Settings',
                          style: GoogleFonts.kavoon(fontSize: 18),
                        ),
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
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Icon(Icons.brush),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 28.0),
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
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .02,
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: Icon(Icons.zoom_in),
                      title: Text('About Us'),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .02,
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: Icon(
                        Icons.privacy_tip_rounded,
                      ),
                      title: Text('Privacy policy'),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .02,
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: Icon(
                        Icons.share,
                      ),
                      title: Text('Share app'),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .02,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 200),
                    child: Container(
                      alignment: Alignment.bottomRight,
                      child: Text('Verion 1.2.0'),
                    ),
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
