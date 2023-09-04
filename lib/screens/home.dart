import 'package:flutter/material.dart';
import 'package:mail_merge/screens/comandos.dart';
import 'package:animate_do/animate_do.dart';

List<String> lista = [];
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController textEditingController = TextEditingController();
  TextEditingController textEditingController2 = TextEditingController();
  FocusNode focusNode = FocusNode();

  late AnimationController animationController1;

  void createSubdomain() {
    bool validacion = _formKey.currentState?.validate() ?? false;

    if (validacion) {
      lista.add(textEditingController2.text);
      textEditingController2.text = "";
    } else {
      animationController1.reset();
      animationController1.forward();
    }
    // if (!lista.contains(textEditingController2.text) &&
    //     !textEditingController2.text.contains(".")) {
    //
    // }

    focusNode.requestFocus();
    setState(() {});
  }

  bool validateNext() {
    bool validar = textEditingController.text != "" &&
        textEditingController.text.contains(".");
    return validar;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("MAIL MERGE"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.15),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.height * 0.1),
                Container(
                  child: Text(
                    "Esta app sirve para poder crear de manera automatizada los comandos de creacion de carpetas y archivos requeridos dentro de un Stack LAMP en un server UBUNTU",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  child: Text(
                    "Completa los siguientes campos para generar tu lista de comandos",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Divider(),
                SizedBox(height: 50),
                Container(
                  child: Text(
                    "Inserte aqui el nombre de su dominio",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: textEditingController,
                    onChanged: (value) {
                      setState(() {});
                    },
                    decoration: InputDecoration(
                        hintText: "myexampleweb.com",
                        border: OutlineInputBorder()),
                  ),
                ),
                SizedBox(height: 50),
                Container(
                  child: Text(
                    "Inserte aqui los nombres de todos los subdominios que desea crear, ingresando uno por uno",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flash(
                      controller: (p0) {
                        animationController1 = p0;
                      },
                      duration: Duration(milliseconds: 500),
                      child: Container(
                        width: size.width * 0.5,
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (textEditingController2.text.contains(".")) {
                              return "Asegurese que el subdominio no contenga puntos";
                            }
                            if (lista.contains(textEditingController2.text)) {
                              return "Ya existe este subdominio en tu lista";
                            }
                            return null;
                          },
                          focusNode: focusNode,
                          controller: textEditingController2,
                          onFieldSubmitted: (value) {
                            createSubdomain();
                          },
                          decoration: InputDecoration(
                              hintText: "", border: OutlineInputBorder()),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        createSubdomain();
                      },
                      child: Icon(Icons.add),
                      style: ButtonStyle(
                          fixedSize: MaterialStatePropertyAll(
                              Size(size.width * 0.03, size.width * 0.03))),
                    ),
                    SizedBox(),
                  ],
                ),
                SizedBox(height: 10),
                Container(
                  child: Text(
                    lista.length == 0 ? "" : lista.toString(),
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: validateNext()
                        ? () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ComandosScreen(
                                    dominio: textEditingController.text,
                                    subdominios: lista,
                                  ),
                                ));
                          }
                        : null,
                    child: Icon(
                      Icons.send,
                      size: 40,
                    ),
                    style: ButtonStyle(
                        fixedSize: MaterialStatePropertyAll(
                            Size(size.width * 0.05, size.width * 0.05))),
                  ),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
