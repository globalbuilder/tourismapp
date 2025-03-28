import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tourism_frontend/core/config/theme/theme_manager.dart';
import 'package:tourism_frontend/core/widgets/theme_toggle_switch.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children: [
              const Text("Dark Mode"),
              const Spacer(),
              ThemeToggleSwitch(
                isDarkMode: themeManager.isDarkMode,
                onToggle: (bool value) {
                  themeManager.setDarkMode(value);
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Additional language toggles or other settings can go here
        ],
      ),
    );
  }
}
