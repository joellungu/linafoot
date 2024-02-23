import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:linafoot/utils/liste_arbitres.dart';
import 'package:linafoot/utils/liste_equipes.dart';
import 'package:linafoot/utils/liste_joueurs.dart';
import 'package:linafoot/utils/recherche.dart';
import 'package:svg_flutter/svg_flutter.dart';

import '../commissaire_controller.dart';

class ActionMatch extends StatelessWidget {
  //
  CommissaireController commissaireController = Get.find();
  //
  TextEditingController numero = TextEditingController();
  //
  TextEditingController minute = TextEditingController();
  //
  TextEditingController note = TextEditingController();
  //
  List etats = [];
  //
  RxInt typeBut = 1.obs;
  //
  RxInt raisonMotif = 1.obs;
  //
  String action;
  ActionMatch(this.action) {
    //
    if ("Avertissements joueurs" == action) {
      etats = [
        "Fautes légères",
        "Comportement anti-sportif",
        "Jeu dangereux",
        "Simulation",
        "Accumulation de fautes",
        "Contestation des décisions de l'arbitre",
        "Retard de jeu",
        "Comportement antisportif envers les adversaires",
        "Non-respect de la distance sur les coups de pied arrêtés",
        "Sortie de terrain sans autorisation",
        "Jeu déloyal",
        "Empêcher une occasion de but",
        "Comportement inapproprié envers les officiels",
        "Retard de reprise du jeu",
        "Infractions répétées",
      ];
    } else if ("Expulsions joueurs" == action) {
      etats = [
        "Foulure grave",
        "Insultes ou comportement violent",
        "Jeu brutal",
        "Main délibérée",
        "Dénigrement de l'arbitre",
        "Deuxième avertissement",
        "Coup de pied de réparation",
        "Comportement antisportif grave",
        "Violence en dehors du terrain",
        "Interruption volontaire du jeu",
        "Insultes racistes ou discriminatoires",
        "Conduite dangereuse",
        "Refus de quitter le terrain",
        "Actes de tricherie",
        "Violation des règles du fair-play",
      ];
    }
  }
  //
  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      appBar: AppBar(
        title: Text(action),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Equipe",
                  style: textStyle,
                ),
              ),
              Container(
                //height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.grey.shade600,
                  ),
                ),
                child: Column(
                  children: [
                    ListTile(
                      onTap: () {
                        //
                        Recherche.affiche(ListEquipe("Equipe"), context);
                      },
                      title: const Text("Ajouter"),
                      trailing: const Icon(Icons.add),
                    ),
                    Obx(
                      () => commissaireController.equipe['nom'] != null
                          ? ListTile(
                              onTap: () {
                                //
                              },
                              leading: SvgPicture.asset(
                                'assets/IcBaselineSportsSoccer.svg',
                                width: 25,
                                height: 25,
                                color: Colors.blue,
                                semanticsLabel: 'GalaPortrait1.svg',
                              ),
                              title: Text(
                                  "${commissaireController.equipe['nom']}"),
                              subtitle: Text(
                                  "${commissaireController.equipe['province']}"),
                              trailing: IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  //
                                  commissaireController.equipe.value = {};
                                },
                              ),
                            )
                          : Container(),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Numéro ",
                  style: textStyle,
                ),
              ),
              TextField(
                controller: numero,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              //
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Joueur",
                  style: textStyle,
                ),
              ),
              Container(
                //height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.grey.shade600,
                  ),
                ),
                child: Column(
                  children: [
                    ListTile(
                      onTap: () {
                        //
                        Recherche.affiche(ListJoueurs(action), context);
                        //
                      },
                      title: const Text("Ajouter"),
                      trailing: const Icon(Icons.add),
                    ),
                    action == "Avertissements joueurs"
                        ? Obx(
                            () => Column(
                              children: List.generate(
                                commissaireController
                                    .avertissementsJoueurs.length,
                                (index) {
                                  Map joueur = commissaireController
                                      .avertissementsJoueurs[index];
                                  //
                                  return ListTile(
                                    onTap: () {
                                      //
                                    },
                                    leading: SvgPicture.asset(
                                      'assets/MakiSoccer11.svg',
                                      width: 25,
                                      height: 25,
                                      color: Colors.blue,
                                      semanticsLabel: 'MakiSoccer11.svg',
                                    ),
                                    title: Text("${joueur['nom']}"),
                                    subtitle: Text("${joueur['categorie']}"),
                                    trailing: IconButton(
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      onPressed: () {
                                        //
                                        commissaireController
                                            .avertissementsJoueurs
                                            .removeAt(index);
                                        //
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),
                          )
                        : action == "Expulsions joueurs"
                            ? Obx(
                                () => Column(
                                  children: List.generate(
                                    commissaireController
                                        .expulssionsJoueurs.length,
                                    (index) {
                                      Map joueur = commissaireController
                                          .expulssionsJoueurs[index];
                                      //
                                      return ListTile(
                                        onTap: () {
                                          //
                                        },
                                        leading: SvgPicture.asset(
                                          'assets/MakiSoccer11.svg',
                                          width: 25,
                                          height: 25,
                                          color: Colors.blue,
                                          semanticsLabel: 'MakiSoccer11.svg',
                                        ),
                                        title: Text("${joueur['nom']}"),
                                        subtitle:
                                            Text("${joueur['categorie']}"),
                                        trailing: IconButton(
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                          onPressed: () {
                                            //
                                            commissaireController
                                                .avertissementsJoueurs
                                                .removeAt(index);
                                            //
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              )
                            : Obx(
                                () => Column(
                                  children: List.generate(
                                    commissaireController.butsJoueurs.length,
                                    (index) {
                                      Map joueur = commissaireController
                                          .butsJoueurs[index];
                                      //
                                      return ListTile(
                                        onTap: () {
                                          //
                                        },
                                        leading: SvgPicture.asset(
                                          'assets/MakiSoccer11.svg',
                                          width: 25,
                                          height: 25,
                                          color: Colors.blue,
                                          semanticsLabel: 'MakiSoccer11.svg',
                                        ),
                                        title: Text("${joueur['nom']}"),
                                        subtitle:
                                            Text("${joueur['categorie']}"),
                                        trailing: IconButton(
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                          onPressed: () {
                                            //
                                            commissaireController
                                                .avertissementsJoueurs
                                                .removeAt(index);
                                            //
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                  ],
                ),
              ),
              //
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Minute",
                  style: textStyle,
                ),
              ),
              TextField(
                controller: minute,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              //
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Avertissements joueurs" == action
                      ? "Motif"
                      : "Expulsions joueurs" == action
                          ? "Raisons"
                          : "Score",
                  style: textStyle,
                ),
              ),
              "Buts joueurs" != action
                  ? Container(
                      padding: const EdgeInsets.only(left: 10),
                      height: 60,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.shade500,
                          width: 1.2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: Obx(
                          () => DropdownButton(
                            isExpanded: true,
                            onChanged: (e) {
                              //
                              raisonMotif.value = e as int;
                            },
                            value: raisonMotif.value,
                            items: List.generate(
                              etats.length,
                              (index) => DropdownMenuItem(
                                value: index + 1,
                                child: Text("${etats[index]}"),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : TextField(
                      controller: note,
                      keyboardType: action == "Buts joueurs"
                          ? TextInputType.number
                          : TextInputType.text,
                      maxLines: action == "Buts joueurs" ? 1 : 5,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
              //
              const SizedBox(
                height: 10,
              ),
              action == "Buts joueurs"
                  ? Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Type de but",
                        style: textStyle,
                      ),
                    )
                  : Container(),
              //
              action == "Buts joueurs"
                  ? Container(
                      padding: const EdgeInsets.only(left: 10),
                      height: 60,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.shade500,
                          width: 1.2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: Obx(
                          () => DropdownButton(
                            onChanged: (e) {
                              //
                              typeBut.value = e as int;
                            },
                            value: typeBut.value,
                            items: const [
                              DropdownMenuItem(
                                child: Text("Auto but"),
                                value: 1,
                              ),
                              DropdownMenuItem(
                                child: Text("Penalité"),
                                value: 2,
                              ),
                              DropdownMenuItem(
                                child: Text("Classique"),
                                value: 3,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Container(),
              //
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  //
                  Map joueur = "Avertissements joueurs" == action
                      ? commissaireController.avertissementsJoueurs[0]
                      : "Expulsions joueurs" == action
                          ? commissaireController.expulssionsJoueurs[0]
                          : commissaireController.butsJoueurs[0];
                  //
                  Map infos = {
                    "type": action,
                    "equipe": commissaireController.equipe.value,
                    "numero": numero.text,
                    "joueur": joueur,
                    "minute": minute.text,
                    "note": note.text,
                    //"type": ["Auto but", "Penalité", "Classique"][typeBut.value]
                  };
                  //
                  if ("Avertissements joueurs" == action &&
                      "Expulsions joueurs" == action) {
                    infos['note'] = etats[raisonMotif.value];
                  } else {
                    infos['note'] =
                        ["Auto but", "Penalité", "Classique"][typeBut.value];
                  }
                  //
                  "Avertissements joueurs" == action
                      ? commissaireController.avertissementsJoueursGeneral
                          .add(infos)
                      : "Expulsions joueurs" == action
                          ? commissaireController.expulssionsJoueursGeneral
                              .add(infos)
                          : commissaireController.butsJoueursGeneral.add(infos);
                  //
                  commissaireController.equipe.value = {};
                  //commissaireController.avertissementsJoueurs.value = [];
                  //commissaireController.expulssionsJoueursGeneral.value = [];
                  //commissaireController.butsJoueursGeneral.value = [];
                  //
                  Get.back();
                  //
                },
                child: Container(
                  height: 50,
                  color: Colors.blue,
                  alignment: Alignment.center,
                  child: const Text(
                    "Ajouter",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              //
            ],
          ),
        ),
      ),
    );
  }

  //
  TextStyle textStyle = TextStyle(
    fontWeight: FontWeight.bold,
  );
}