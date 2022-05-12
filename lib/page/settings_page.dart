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
  SettingsState createState() => SettingsState();
}

class SettingsState extends State<SettingsPage> {
  final TextEditingController qrCodeURLController = TextEditingController();

  @override
  void initState() {
    super.initState();
    qrCodeURLController.text = widget.settings.agendaURL;
    print('settings: ${widget.settings.agendaURL}');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 20),
            child: Text(
              'Paramètres',
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyText1!.color,
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
                value: widget.settings.darkMode,
                onChanged: (bool b) {
                  setState(() {
                    widget.settings.darkMode = b;
                    widget.onSettingsChanged(widget.settings);
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
                value: widget.settings.newGradeNotification,
                onChanged: (bool b) {
                  widget.settings.newGradeNotification = b;
                  widget.onSettingsChanged(widget.settings);
                },
              ),
              TextSwitch(
                text: 'Forcer les notes en vert',
                value: widget.settings.forceGreen,
                onChanged: (bool b) {
                  widget.settings.forceGreen = b;
                  widget.onSettingsChanged(widget.settings);
                },
              ),
              TextSwitch(
                text: 'Montrer les UEs cachées',
                value: widget.settings.showHiddenUE,
                onChanged: (bool b) {
                  widget.settings.showHiddenUE = b;
                  widget.onSettingsChanged(widget.settings);
                },
              ),
            ],
          ),
          SettingsCard(
            name: 'Agenda',
            widgets: [
              TextSwitch(
                text: 'Montrer le mini calendrier en haut de page',
                value: widget.settings.showMiniCalendar,
                onChanged: (bool b) {
                  widget.settings.showMiniCalendar = b;
                  widget.onSettingsChanged(widget.settings);
                },
              ),
              TextSwitch(
                text: 'Récupérer automatiquement les ressources de l\'agenda',
                value: widget.settings.fetchAgendaAuto,
                onChanged: (bool b) {
                  widget.settings.fetchAgendaAuto = b;
                  widget.onSettingsChanged(widget.settings);
                },
              ),
              !widget.settings.fetchAgendaAuto
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
                                widget.settings.agendaURL = value;
                                print('value: ${widget.settings.agendaURL}');
                                widget.onSettingsChanged(widget.settings);
                              },
                              decoration: const InputDecoration(
                                filled: true,
                                labelStyle: TextStyle(fontSize: 12),
                                hintStyle: TextStyle(fontSize: 12),
                                hintText: 'URL de l\'agenda',
                                border: InputBorder.none,
                                fillColor: Color(0xffd8dee9),
                              ),
                            ),
                          ),
                          Container(
                            color: const Color(0xffd8dee9),
                            child: IconButton(
                              onPressed: () async {
                                final String? url = await Navigator.of(context)
                                    .push(MaterialPageRoute(
                                  builder: (context) => const QrCodeScanner(),
                                ));
                                qrCodeURLController.value = TextEditingValue(
                                    text:
                                        url ?? qrCodeURLController.value.text);
                                widget.settings.agendaURL =
                                    url ?? widget.settings.agendaURL;
                                widget.onSettingsChanged(widget.settings);
                              },
                              enableFeedback: true,
                              splashColor: Colors.transparent,
                              icon: const Icon(
                                Icons.qr_code,
                                color: Color(0xff4c566a),
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
                value: widget.settings.newMailNotification,
                onChanged: (bool b) {
                  widget.settings.newMailNotification = b;
                  widget.onSettingsChanged(widget.settings);
                },
              ),
              TextSwitch(
                text: 'Bloquer les trackers',
                value: widget.settings.blockTrackers,
                onChanged: (bool b) {
                  widget.settings.blockTrackers = b;
                  widget.onSettingsChanged(widget.settings);
                },
              ),
            ],
          ),
          SettingsCard(
            name: 'Connexion',
            widgets: [
              TextSwitch(
                text: 'Rester connecté',
                value: widget.settings.keepMeLoggedIn,
                onChanged: (bool b) {
                  widget.settings.keepMeLoggedIn = b;
                  widget.onSettingsChanged(widget.settings);
                },
              ),
              const SizedBox(height: 20),
              MaterialButton(
                minWidth: MediaQuery.of(context).size.width,
                color: const Color(0xffbf616a),
                textColor: Colors.white70,
                child: const Text('Déconnexion'),
                onPressed: () {
                  widget.settings.username = '';
                  widget.settings.password = '';
                  widget.onSettingsChanged(widget.settings);
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
