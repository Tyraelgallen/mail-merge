// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:clipboard/clipboard.dart';
import 'package:mail_merge/constants.dart';

class ComandosScreen extends StatefulWidget {
  final String dominio;
  final List subdominios;
  const ComandosScreen(
      {super.key, required this.dominio, required this.subdominios});

  @override
  State<ComandosScreen> createState() => _ComandosScreenState();
}

class _ComandosScreenState extends State<ComandosScreen> {
  PageController controller = PageController(initialPage: 0);

  @override
  void initState() {
    //TODO ULTIMO CAMBIO
    widget.subdominios.insert(0, "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Comandos"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.15),
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 50),
                Center(
                    child: Text(
                  "Aqui estan tus comandos para poder crear dominios y subdominios",
                  style: TextStyle(fontSize: 25),
                )),
                Container(
                  width: size.width * 0.6,
                  height: size.height * 0.8,
                  child: PageView.builder(
                    controller: controller,
                    onPageChanged: (value) {},
                    itemCount: widget.subdominios.length,
                    itemBuilder: (context, index) {
                      return SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 50),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "DOMINIO:   " +
                                    widget.subdominios[index] +
                                    (index != 0 ? "." : "") +
                                    widget.dominio,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(height: 30),
                            TextoCopia(
                              text: crearCarpeta(
                                  domin: widget.dominio,
                                  subd: widget.subdominios[index]),
                              titleIndex: 1,
                            ),
                            SizedBox(height: 20),
                            TextoCopia(
                              text: cambiarPermisos(
                                  domin: widget.dominio,
                                  subd: widget.subdominios[index]),
                              titleIndex: 2,
                            ),
                            SizedBox(height: 20),
                            TextoCopia(
                              text: crearHTML(
                                  domin: widget.dominio,
                                  subd: widget.subdominios[index]),
                              titleIndex: 3,
                            ),
                            SizedBox(height: 20),
                            TextoCopia(
                              text: crearSitio(
                                  domin: widget.dominio,
                                  subd: widget.subdominios[index]),
                              titleIndex: 4,
                            ),
                            SizedBox(height: 20),
                            TextoCopia(
                              text: habilitarSitio(
                                  domin: widget.dominio,
                                  subd: widget.subdominios[index]),
                              titleIndex: 5,
                            ),
                            SizedBox(height: 200),
                          ],
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(left: 50, bottom: 10, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton(
              onPressed: () {
                controller.previousPage(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.bounceOut);
              },
              child: Icon(Icons.arrow_back),
              heroTag: "b1",
            ),
            SizedBox(width: size.width * 0.3),
            FloatingActionButton(
              onPressed: () {
                controller.nextPage(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.bounceOut);
              },
              child: Icon(Icons.arrow_forward),
              heroTag: "b2",
            )
          ],
        ),
      ),
    );
  }
}

class TextoCopia extends StatefulWidget {
  final String text;
  final int titleIndex;
  const TextoCopia({
    super.key,
    required this.text,
    required this.titleIndex,
  });

  @override
  State<TextoCopia> createState() => _TextoCopiaState();
}

class _TextoCopiaState extends State<TextoCopia> {
  bool visible = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        (visible && textosExplicativos(widget.titleIndex) != "")
            ? Text(
                textosExplicativos(widget.titleIndex),
                style: TextStyle(fontSize: 17),
              )
            : SizedBox(),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 48, 47, 47),
                  borderRadius: BorderRadius.circular(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.text,
                    style: TextStyle(fontSize: 17, color: Colors.white),
                  ),
                  IconButton(
                      onPressed: () {
                        FlutterClipboard.copy(widget.text).then((value) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                              "Copiado ${widget.text}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 22),
                            ),
                            duration: Duration(seconds: 1),
                          ));
                        });
                      },
                      icon: Icon(Icons.copy, color: Colors.white))
                ],
              ),
            ),
            SizedBox(width: 20),
            IconButton(
                onPressed: () {
                  visible = !visible;
                  setState(() {});
                },
                icon: Icon(Icons.question_mark))
          ],
        ),
      ],
    );
  }
}
