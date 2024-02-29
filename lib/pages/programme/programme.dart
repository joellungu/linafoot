import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:linafoot/pages/programme/programme_matchs.dart';
import 'package:linafoot/utils/loader.dart';

import 'programme_controller.dart';

class Programme extends GetView<ProgrammeController> {
  @override
  Widget build(BuildContext context) {
    //
    return Container(
      //color: Colors.red, // Status bar color
      // decoration: BoxDecoration(
      //   gradient: LinearGradient(
      //     begin: Alignment.topLeft,
      //     end: Alignment.bottomRight,
      //     colors: [
      //       Colors.black,
      //       Colors.black,
      //       Colors.black,
      //       Colors.black,
      //       Colors.black,
      //     ],
      //   ),
      // ),
      child: SafeArea(
        left: false,
        right: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: Loader.backgroundColor,
          appBar: AppBar(
            title: const Text("Calendrier de Match"),
            centerTitle: true,
            backgroundColor: Loader.backgroundColor,
            bottom: PreferredSize(
              preferredSize: Size(10, 40),
              child: Container(
                padding: const EdgeInsets.only(bottom: 10),
                alignment: Alignment.center,
                child: Text(
                  "Calendrier officiel du playoff",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ),
          body: Column(
            children: [
              Expanded(
                  flex: 1,
                  child: FutureBuilder(
                    future: controller.getCalendrier(),
                    builder: (c, t) {
                      //
                      if (t.hasData) {
                        var id = t.data as int;
                        print("id: $id");
                        return ProgrammeMatchs('$id', "playoff");
                      } else if (t.hasError) {
                        return Container();
                      }
                      return Center(
                        child: Container(
                          height: 40,
                          width: 40,
                          child: const CircularProgressIndicator(),
                        ),
                      );
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
