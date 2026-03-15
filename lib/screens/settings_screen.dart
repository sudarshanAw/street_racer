import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../utils/storage_helper.dart';

/// Simple settings page – currently just a sound toggle.
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late bool _soundEnabled;

  @override
  void initState() {
    super.initState();
    _soundEnabled = StorageHelper.isSoundEnabled();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.menuBg,
      appBar: AppBar(
        title: const Text('SETTINGS'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            _settingTile(
              icon: _soundEnabled ? Icons.volume_up : Icons.volume_off,
              label: 'Sound Effects',
              trailing: Switch(
                value: _soundEnabled,
                activeColor: AppColors.accent,
                onChanged: (val) {
                  setState(() => _soundEnabled = val);
                  StorageHelper.setSoundEnabled(val);
                },
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'Street Racer v1.0',
              style: TextStyle(
                color: AppColors.textSecondary.withOpacity(0.5),
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _settingTile({
    required IconData icon,
    required String label,
    required Widget trailing,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.menuCard,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.accent, size: 28),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 18,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          trailing,
        ],
      ),
    );
  }
}
