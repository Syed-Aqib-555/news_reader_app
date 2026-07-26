import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text("Dark Mode"),
            subtitle: const Text("Enable or disable dark theme"),
            value: themeProvider.isDarkMode,
            onChanged: (value) {
              themeProvider.toggleTheme();
            },
          ),

          const Divider(),

          const ListTile(
            leading: Icon(Icons.info),
            title: Text("Version"),
            subtitle: Text("1.0.0"),
          ),

          const Divider(),

          const ListTile(
            leading: Icon(Icons.person),
            title: Text("Developer"),
            subtitle: Text("Syed Aqib"),
          ),
        ],
      ),
    );
  }
}
