import 'package:flutter/material.dart';
import 'package:foods/components/main_drawer.dart';
import 'package:foods/models/settings.dart';

class SettingsScreen extends StatefulWidget {

  final Settings settings;
  final Function(Settings) onSettingChanged;

  const SettingsScreen(this.settings, this.onSettingChanged, {Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Settings? settings;

  @override
  void initState() {
    super.initState();
    settings = widget.settings;
  }

  Widget _createSwitch(
    String title,
    String subtitle,
    bool value,
    Function(bool) onChanged,
  ) {
    return SwitchListTile.adaptive(
      title: Text(title),
      subtitle: Text(subtitle),
      value: value,
      onChanged: (value) {
        onChanged(value);
        widget.onSettingChanged(settings!);
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Configurações',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _createSwitch(
                  'Sem Gluten',
                  'Só exibe refeições sem gluten',
                  settings!.isGlutenFree,
                  (value) => setState(() => settings!.isGlutenFree = value),
                ),
                _createSwitch(
                  'Sem Lactose',
                  'Só exibe refeições sem lactose',
                  settings!.isLactoseFree,
                      (value) => setState(() => settings!.isLactoseFree = value),
                ),
                _createSwitch(
                  'Vegana',
                  'Só exibe refeições veganas',
                  settings!.isVegan,
                      (value) => setState(() => settings!.isVegan = value),
                ),
                _createSwitch(
                  'Vegetariana',
                  'Só exibe refeições vegetariana',
                  settings!.isVegetarian,
                      (value) => setState(() => settings!.isVegetarian = value),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
