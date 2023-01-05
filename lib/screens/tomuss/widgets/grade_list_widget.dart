import 'package:flutter/material.dart';
import 'package:onyx/screens/tomuss/tomuss_export.dart';
import 'package:sizer/sizer.dart';

class GradeListWidget extends StatelessWidget {
  const GradeListWidget(
      {Key? key,
      required this.grades,
      required this.depth,
      required this.lastElement})
      : super(key: key);
  final List<GradeModel> grades;
  final int depth;
  final bool lastElement;

  @override
  Widget build(BuildContext context) {
    return Column(
      children:
          List.generate(grades.length, (index) => index).map((gradeIndex) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (depth == 1)
              Container(
                height: 2.h,
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                treeBuilder(context, depth, gradeIndex == grades.length - 1,
                    lastElement),
                Expanded(
                  child: SizedBox(
                    height: 11.h,
                    child: GradeWidget(
                      grades: [grades[gradeIndex]],
                      isSeen: true,
                      text1: grades[gradeIndex].name,
                      text2:
                          "moyenne: ${grades[gradeIndex].average.toStringAsFixed(2)} · mediane: ${grades[gradeIndex].mediane.toStringAsFixed(2)}\nclassement:${grades[gradeIndex].rank + 1}/${grades[gradeIndex].groupSize}\nprofesseur: ${grades[gradeIndex].author}",
                      depth: depth,
                    ),
                  ),
                ),
              ],
            ),
            if (grades[gradeIndex].children.isNotEmpty)
              GradeListWidget(
                grades: grades[gradeIndex].children,
                depth: depth + 1,
                lastElement: gradeIndex == grades.length - 1,
              ),
          ],
        );
      }).toList(),
    );
  }

  Widget treeBuilder(BuildContext context, int depth, bool lastElement,
      bool parentLastElement) {
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
        for (var i = 0; i < ((parentLastElement) ? 1 : depth - 1); i++)
          Padding(
            padding: EdgeInsets.only(
              left: (parentLastElement)
                  ? (depth == 2)
                      ? 10.w
                      : ((10.w + 3.w) * (depth - 1)) - 3.w
                  : (i == 0)
                      ? 10.w
                      : 10.w + 3.w,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 1.w,
                  height:
                      ((lastElement && (i >= depth - 2 || parentLastElement))
                          ? (13.h / 2) + (0.5.h / 2)
                          : 13.h),
                  color: Theme.of(context).primaryColor,
                ),
                Container(
                  width: 1.w,
                  height:
                      ((lastElement && (i >= depth - 2 || parentLastElement))
                          ? (13.h / 2) - (0.5.h / 2)
                          : 0),
                  color: Theme.of(context).backgroundColor,
                ),
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
