// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:golearnv2/components/settings/settings_tile.dart';
import 'package:golearnv2/databases/database_manager.dart';
import 'package:golearnv2/utils/methods.dart';
import 'package:provider/provider.dart';
import 'package:golearnv2/components/app/custom_appbar.dart';
import 'package:golearnv2/components/settings/switch_button.dart';
import 'package:golearnv2/configs/constants.dart';
import 'package:golearnv2/enums/settings.dart';
import 'package:golearnv2/notifiers/settings_notifier.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

//THIS IS THE CODE FOR THE SETTINGS PAGE

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsNotifier>(
      builder: (_, notifier, __) {
        bool audioFirst = notifier.displayOptions.entries
            .firstWhere((element) => element.key == Settings.audioOnly)
            .value;

        return Scaffold(
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(kAppBarHeight),
              child: CustomAppBar()),
          body: Stack(
            children: [
              Column(
                children: [
                  SwitchButton(
                      disabled: audioFirst, displayOption: Settings.showWord),
                  SwitchButton(
                      disabled: audioFirst, displayOption: Settings.showType),
                  SwitchButton(displayOption: Settings.audioOnly),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    color: Colors.white,
                    child: SettingsTile(
                      Theme.of(context).listTileTheme,
                      title: 'Reset',
                      icon: const Icon(Icons.refresh),
                      callback: () async {
                        notifier.resetSettings();
                        runQuickBox(context: context, text: 'Settings Reset');
                        await DatabaseManager().removeDatabase();

                        Future.delayed(const Duration(milliseconds: 1000), () {
                          if (!mounted) return;
                          Navigator.maybePop(context);
                        });
                      },
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: SettingsTile(
                      Theme.of(context).listTileTheme,
                      title: 'Exit App',
                      icon: const Icon(
                        Icons.exit_to_app,
                      ),
                      callback: () {
                        SystemChannels.platform
                            .invokeMethod('SystemNavigator.pop');
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
