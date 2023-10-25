import 'package:flutter/material.dart';
import 'package:mail_merge/providerLanguage/lang_selector.dart';
import 'package:mail_merge/screens/comandos.dart';
import 'package:animate_do/animate_do.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

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
        title: Text(AppLocalizations.of(context)!.tituloapp),
        centerTitle: true,
        actions: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            width: 300,
            // height: 20,
            child: LanguageSelect(),
          )
        ],
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
                    AppLocalizations.of(context)!.descripcion1,
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  child: Text(
                    AppLocalizations.of(context)!.descripcion2,
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Divider(),
                SizedBox(height: 50),
                Container(
                  child: Text(
                    AppLocalizations.of(context)!.inserte1,
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
                    AppLocalizations.of(context)!.inserte2,
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
                            String t = textEditingController2.text;
                            if (t.contains(RegExp(r'[^\w\d]+'))) {
                              return AppLocalizations.of(context)!.subderror1;
                            }
                            if (lista.contains(t)) {
                              return AppLocalizations.of(context)!.subderror2;
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
                    lista.length == 0
                        ? ""
                        : lista.where((element) => element != "").toString(),
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
                                    dominio: textEditingController.text
                                        .toLowerCase(),
                                    subdominios: lista
                                        .map((e) => e.toLowerCase())
                                        .toList(),
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
