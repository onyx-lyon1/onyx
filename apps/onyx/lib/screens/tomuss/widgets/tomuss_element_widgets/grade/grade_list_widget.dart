import 'package:flutter/material.dart';
import 'package:lyon1tomussclient/lyon1tomussclient.dart';
import 'package:onyx/screens/tomuss/tomuss_export.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GradeListWidget extends StatelessWidget {
  const GradeListWidget(
      {super.key,
      required this.grades,
      this.depth = 1,
      this.lastElement = true});
  final Grade grades;
  final int depth;
  final bool lastElement;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        // if (depth == 1)
        //   Container(
        //     height: 2.h,
        //   ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            treeBuilder(context, depth, lastElement),
            Expanded(
              child: SizedBox(
                height: 10.h,
                child: GradeWidget(
                  grades: [grades],
                  isSeen: true,
                  text1: grades.title.replaceAll("_", " "),
                  text2:
                  AppLocalizations.of(context).noteDescription(grades.average, grades.mediane, grades.rank + 1, grades.groupeSize, grades.author),
                  depth: depth,
                ),
              ),
            ),
          ],
        ),
        if (grades.children.isNotEmpty)
          Column(
            children: [
              for (var grade in grades.children)
                GradeListWidget(
                  grades: grade,
                  depth: depth + 1,
                  lastElement: grades.children.indexOf(grade) ==
                      grades.children.length - 1,
                ),
            ],
          ),
      ],
    );
  }

  Widget treeBuilder(BuildContext context, int depth, bool lastElement) {
    if (depth == 1) {
      return Container();
    }
    //ATTENTION ATTENTION, VOUS ENTREZ DANS DES ENTRAILLES SOMBRE DE LA PROGRAMMATION
    //CE QUE VOUS VERREZ ICI PEUT HEURTER VOTRE SENSIBILITE, VOUS CHOQUER
    //ET VOUS FAIRE PERDRE LA FOI EN L'HUMANITE
    //VOUS ETES PREVENU
    //SI VOUS VOULEZ VOUS EN SORTIR, CLIQUEZ SUR LE BOUTON ROUGE EN HAUT A DROITE
    //ET FUITEZ
    //SI VOUS VOULEZ CONTINUER, BONNE CHANCE A VOUS ET A VOTRE AME
    //ET PENSEZ A VOTRE FAMILLE
    //ET A VOS ENFANTS
    //ET A VOS PETITS ENFANTS
    //ET A VOS PETITS PETITS ENFANTS
    //ET A VOS PETITS PETITS PETITS ENFANTS
    //ET A VOS PETITS PETITS PETITS PETITS ENFANTS
    //ET SACHEZ QUE VOUS AVEZ FAIT LE CHOIX
    //JE NE SUIS PAS RESPONSABLE
    // JE NE VOUS ACCOMPAGNERAI PAS DANS CE PÉRIPLE, QUE DIJE, VOTRE DESCENTE AUX ENFERS
    //ADIEUX SOLDAT ET BONNE CHANCE
    //ET PENSEZ A VOTRE FAMILLE !
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        for (var i = 0; i < ((lastElement) ? 1 : depth - 1); i++)
          Padding(
            padding: EdgeInsets.only(
              left: (lastElement)
                  ? (depth == 2)
                      ? 10.w
                      : ((10.w + 3.w) * (depth - 1)) - 3.w
                  : (i == 0)
                      ? 10.w
                      : 10.w + 2.w,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (i >= depth - 2 || lastElement)
                  Container(
                    width: 1.w,
                    height: ((lastElement) ? 6.5.h + 0.25.h : 13.h),
                    color: Theme.of(context).primaryColor,
                  ),
                Container(
                    width: 1.w,
                    height: (lastElement) ? 6.5.h - 0.25.h : 0,
                    color: Colors.transparent),
              ],
            ),
          ),
        Container(
          width: 3.w,
          height: 0.5.h,
          color: Theme.of(context).primaryColor,
        ),
      ],
    );
  }
}
