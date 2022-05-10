import 'package:flutter/material.dart';
import 'package:oloid2/model/settings.dart';
import 'package:oloid2/page/qr_code_scanner.dart';
import 'package:oloid2/widget/settings_card.dart';
import 'package:oloid2/widget/text_switch.dart';

class SettingsPage extends StatefulWidget {
  final SettingsModel settings;
  final Function(SettingsModel settings) onSettingsChanged;

  const SettingsPage({
    Key? key,
    required this.settings,
    required this.onSettingsChanged,
  }) : super(key: key);

  @override
  SettingsState createState() => SettingsState(
        settings: settings,
        onSettingsChanged: onSettingsChanged,
      );
}

class SettingsState extends State<SettingsPage> {
  final TextEditingController qrCodeURLController = TextEditingController();
  final SettingsModel settings;
  final Function(SettingsModel settings) onSettingsChanged;

  SettingsState({
    required this.settings,
    required this.onSettingsChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 10, top: 20),
            child: Text(
              'Paramètres',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SettingsCard(
            name: 'Général',
            widgets: [
              TextSwitch(
                text: 'Activer le thème sombre',
                value: settings.darkMode,
                onChanged: (bool b) {
                  settings.darkMode = b;
                  setState(() {});
                  onSettingsChanged(settings);
                },
              )
            ],
          ),
          SettingsCard(
            name: 'Tomuss',
            widgets: [
              TextSwitch(
                text: 'Notification en cas de nouvelle note',
                value: settings.newGradeNotification,
                onChanged: (bool b) {
                  settings.newGradeNotification = b;
                  setState(() {});
                },
              ),
              TextSwitch(
                text: 'Forcer les notes en vert',
                value: settings.forceGreen,
                onChanged: (bool b) {
                  settings.forceGreen = b;
                  setState(() {});
                },
              ),
              TextSwitch(
                text: 'Montrer les UEs cachées',
                value: settings.showHiddenUE,
                onChanged: (bool b) {
                  settings.showHiddenUE = b;
                  setState(() {});
                },
              ),
            ],
          ),
          SettingsCard(
            name: 'Agenda',
            widgets: [
              TextSwitch(
                text: 'Récupérer automatiquement les ressources de l\'agenda',
                value: settings.fetchAgendaAuto,
                onChanged: (bool b) {
                  settings.fetchAgendaAuto = b;
                  setState(() {});
                },
              ),
              !settings.fetchAgendaAuto
                  ? Container(
                      clipBehavior: Clip.hardEdge,
                      margin: const EdgeInsets.only(bottom: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 110,
                            child: TextField(
                              controller: qrCodeURLController,
                              enableSuggestions: false,
                              onChanged: (String value) {
                                print('AGENDA: ' + value);
                              },
                              decoration: const InputDecoration(
                                filled: true,
                                labelStyle: TextStyle(fontSize: 12),
                                hintStyle: TextStyle(fontSize: 12),
                                hintText: 'URL de l\'agenda',
                                border: InputBorder.none,
                                fillColor: Colors.white,
                              ),
                            ),
                          ),
                          Container(
                            color: Colors.white,
                            child: IconButton(
                              onPressed: () async {
                                final String? url = await Navigator.of(context)
                                    .push(MaterialPageRoute(
                                  builder: (context) => const QrCodeScanner(),
                                ));
                                qrCodeURLController.value =
                                    TextEditingValue(text: url ?? '');
                              },
                              enableFeedback: true,
                              splashColor: Colors.transparent,
                              icon: Icon(
                                Icons.qr_code,
                                color: Theme.of(context).backgroundColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(),
            ],
          ),
          SettingsCard(
            name: 'Email',
            widgets: [
              TextSwitch(
                text: 'Notification en cas de nouveau mail',
                value: settings.newMailNotification,
                onChanged: (bool b) {
                  settings.newMailNotification = b;
                  setState(() {});
                },
              ),
              TextSwitch(
                text: 'Bloquer les trackers',
                value: settings.blockTrackers,
                onChanged: (bool b) {
                  settings.blockTrackers = b;
                  setState(() {});
                },
              ),
            ],
          ),
          SettingsCard(
            name: 'Connexion',
            widgets: [
              TextSwitch(
                text: 'Rester connecté',
                value: settings.keepMeLoggedIn,
                onChanged: (bool b) {
                  settings.keepMeLoggedIn = b;
                  setState(() {});
                },
              ),
              const SizedBox(height: 20),
              MaterialButton(
                minWidth: MediaQuery.of(context).size.width,
                color: const Color(0xffbf616a),
                textColor: Colors.white,
                child: const Text('Déconnexion'),
                onPressed: () {
                  settings.username = '';
                  settings.password = '';
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
