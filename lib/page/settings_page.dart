import 'package:flutter/material.dart';
import 'package:oloid2/model/settings.dart';
import 'package:oloid2/page/qr_code_scanner.dart';
import 'package:oloid2/widget/settings_card.dart';
import 'package:oloid2/widget/text_switch.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  SettingsState createState() => SettingsState();
}

class SettingsState extends State<SettingsPage> {
  final TextEditingController qrCodeURLController = TextEditingController();
  late SettingsModel settings;

  @override
  void initState() {
    super.initState();
    settings =
        SettingsModel('p1234567', 'myPassword'); // TODO: load from memory
  }

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
                  setState(() {
                    settings.darkMode = b;
                  });
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
                  setState(() {
                    settings.newGradeNotification = b;
                  });
                },
              ),
              TextSwitch(
                text: 'Forcer les notes en vert',
                value: settings.forceGreen,
                onChanged: (bool b) {
                  setState(() {
                    settings.forceGreen = b;
                  });
                },
              ),
              TextSwitch(
                text: 'Montrer les UEs cachées',
                value: settings.showHiddenUE,
                onChanged: (bool b) {
                  setState(() {
                    settings.showHiddenUE = b;
                  });
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
                  setState(() {
                    settings.fetchAgendaAuto = b;
                  });
                },
              ),
              !settings.fetchAgendaAuto
                  ? Container(
                      clipBehavior: Clip.hardEdge,
                      margin: const EdgeInsets.only(bottom: 15),
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(4)),
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
                                  fillColor: Colors.white),
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
              // TODO: champs de texte + scanner QR code
            ],
          ),
          SettingsCard(
            name: 'Email',
            widgets: [
              TextSwitch(
                text: 'Notification en cas de nouveau mail',
                value: settings.newMailNotification,
                onChanged: (bool b) {
                  setState(() {
                    settings.newMailNotification = b;
                  });
                },
              ),
              TextSwitch(
                text: 'Bloquer les trackers',
                value: settings.blockTrackers,
                onChanged: (bool b) {
                  setState(() {
                    settings.blockTrackers = b;
                  });
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
                  setState(() {
                    settings.keepMeLoggedIn = b;
                  });
                },
              ),
              const SizedBox(height: 20),
              MaterialButton(
                minWidth: MediaQuery.of(context).size.width,
                color: const Color(0xffbf616a),
                textColor: Colors.white,
                child: const Text('Déconnexion'),
                onPressed: () {
                  setState(() {
                    settings.username = '';
                    settings.password = '';
                  });
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
