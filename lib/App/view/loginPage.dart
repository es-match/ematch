// import 'package:ematch/controllers/sign_in.dart';

import 'package:ematch/App/controller/sign_in.dart';
import 'package:ematch/App/custom_widgets/background_painter.dart';
import 'package:ematch/App/view/OwnerViews/_ownerMainPage.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'UserViews/_userMainPage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  bool signupVisible = false;
  bool loadingVisible = false;
  String email;
  String password;
  String name;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  void login() {
    showLoadBar();
    if (formkey.currentState.validate()) {
      formkey.currentState.save();
      signin(email, password, context).then((value) {
        if (value != null) {
          if (myRole == "Standard") {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => MainPage(),
                ));
          } else if (myRole == "PlaceOwner") {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => OwnerMainPage(),
                ));
          }
        } else {
          hideLoadBar();
        }
      }).catchError((e) {
        hideLoadBar();
      });
    }
    hideLoadBar();
  }

  void createUser() {
    showLoadBar();
    if (formkey.currentState.validate()) {
      formkey.currentState.save();
      signUp(email, password, name, context).then((value) {
        if (value != null) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MainPage(),
              ));
        } else {
          hideLoadBar();
        }
      }).catchError(() => hideLoadBar());
    }
    hideLoadBar();
  }

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    super.initState();
  }

  void showSignUp() {
    setState(() {
      signupVisible = true;
    });
  }

  void hideSignUp() {
    setState(() {
      signupVisible = false;
    });
  }

  void showLoadBar() {
    setState(() {
      loadingVisible = true;
    });
  }

  void hideLoadBar() {
    setState(() {
      loadingVisible = false;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.height,
                child: Stack(
          children: [
            SizedBox.expand(
                child: CustomPaint(
                  painter: BackgroundPainter(
                    animation: _controller.view,
                  ),
                ),
            ),
            Center(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: Center(
                    child: Form(
                      key: formkey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Visibility(
                            visible: !loadingVisible,
                            child: Column(
                              children: [
                                Image(
                                    image: AssetImage("assets/icon/icon_logo.png"),
                                    height: 140.0),
                                SizedBox(
                                  height: 20,
                                ),
                                SingleChildScrollView(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey[900],
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: TextFormField(
                                      style: TextStyle(
                                        color: Colors.deepOrange,
                                      ),
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(
                                            const Radius.circular(8.0),
                                          ),
                                          borderSide: new BorderSide(
                                            color: Colors.deepOrange,
                                            width: 1.0,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.deepOrange, width: 1.0),
                                        ),
                                        labelText: "E-mail",
                                        labelStyle: TextStyle(
                                          color: Colors.deepOrange,
                                        ),
                                      ),
                                      validator: MultiValidator([
                                        RequiredValidator(
                                            errorText: "Campo obrigatório"),
                                        EmailValidator(
                                            errorText: "E-mail Inválido"),
                                      ]),
                                      onChanged: (val) {
                                        email = val;
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey[900],
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: TextFormField(
                                      style: TextStyle(
                                        color: Colors.deepOrange,
                                      ),
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        border: new OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(
                                            const Radius.circular(8.0),
                                          ),
                                          borderSide: new BorderSide(
                                            color: Colors.deepOrange,
                                            width: 1.0,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.deepOrange, width: 1.0),
                                        ),
                                        labelText: "Senha",
                                        labelStyle: TextStyle(
                                          color: Colors.deepOrange,
                                        ),
                                      ),
                                      validator: MultiValidator([
                                        RequiredValidator(
                                            errorText:
                                                "É necessário inserir a senha"),
                                        MinLengthValidator(6,
                                            errorText: "Mínimo de 6 caractéres"),
                                      ]),
                                      onChanged: (val) {
                                        password = val;
                                      },
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: signupVisible,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 15.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey[900],
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      child: TextFormField(
                                        style: TextStyle(
                                          color: Colors.deepOrange,
                                        ),
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius: const BorderRadius.all(
                                              const Radius.circular(8.0),
                                            ),
                                            borderSide: new BorderSide(
                                              color: Colors.deepOrange,
                                              width: 1.0,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.deepOrange,
                                                width: 1.0),
                                          ),
                                          labelText: "Nome/Apelido",
                                          labelStyle: TextStyle(
                                            color: Colors.deepOrange,
                                          ),
                                        ),
                                        validator: MultiValidator([
                                          RequiredValidator(
                                            errorText: "Campo Obrigatório",
                                          )
                                        ]),
                                        onChanged: (val) {
                                          name = val;
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                _createAccButton(),
                                _signInButton(),
                                _signInButtonGoogle(),
                                _signInModeButton(),
                                _signUpModeButton(),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: loadingVisible,
                            child: Column(
                              children: [
                                Image(
                                    image: AssetImage("assets/loadingenter.gif"),
                                    height: 140.0),
                                Text(
                                  "Por favor, aguarde...",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    'Quer registrar seu espaço esportivo? Contate-nos pelo e-mail: esmatchar@gmail.com',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
            ),
          ],
        ),
              ),
      ),
      backgroundColor: Colors.black,
    );
    // Widget build(BuildContext context) {
    //   return Scaffold(
    //     body: Container(
    //       decoration: BoxDecoration(
    //         gradient: LinearGradient(
    //             begin: Alignment.topRight,
    //             end: Alignment.bottomLeft,
    //             colors: [
    //               // Colors.orange[900],
    //               // Colors.orange[800],
    //               Colors.blue,
    //               // Colors.deepOrange[500],
    //               // Colors.orange,
    //             ],
    //             stops: [
    //               // 0.1,
    //               // 0.2,
    //               0.1,
    //               //  0.6,
    //               // 0.9,
    //             ]),
    //       ),
    //       child: Center(
    //         child: Column(
    //           mainAxisSize: MainAxisSize.max,
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: <Widget>[
    //             Image(image: AssetImage("assets/logoesm.png"), height: 150.0),
    //             SizedBox(height: 50),
    //             _signInButton(),
    //           ],
    //         ),
    //       ),
    //     ),
    //   );
  }

  Widget _signInModeButton() {
    return Visibility(
      visible: signupVisible,
      // ignore: deprecated_member_use
      child: RaisedButton(
        color: Colors.black26,
        splashColor: Colors.white,
        onPressed: () {
          hideSignUp();
          _controller.reverse(from: 2);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        highlightElevation: 1,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 2, 0, 2),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.keyboard_return,
                color: Colors.grey,
                size: 20.0,
                semanticLabel: 'Volte para tela de log-in',
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'Voltar para Login',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _signUpModeButton() {
    return Visibility(
      visible: !signupVisible,
      // ignore: deprecated_member_use
      child: RaisedButton(
        color: Colors.black26,
        splashColor: Colors.white,
        onPressed: () {
          showSignUp();
          _controller.forward(from: 0);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        highlightElevation: 1,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 2, 0, 2),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.person_add,
                color: Colors.grey,
                size: 20.0,
                semanticLabel: 'Crie um novo cadastro',
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'Cadastrar',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _createAccButton() {
    return Visibility(
      visible: signupVisible,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        // ignore: deprecated_member_use
        child: RaisedButton(
          color: Colors.black26,
          splashColor: Colors.white,
          onPressed: createUser,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          highlightElevation: 1,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 2, 0, 2),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.login,
                  color: Colors.grey,
                  size: 30.0,
                  semanticLabel: 'Crie uma nova conta',
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'Criar nova conta',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.grey,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _signInButton() {
    return Visibility(
      visible: !signupVisible,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        // ignore: deprecated_member_use
        child: OutlineButton(
          splashColor: Colors.grey,
          onPressed: login,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          highlightElevation: 1,
          highlightedBorderColor: Colors.white,
          borderSide: BorderSide(color: Colors.grey[600]),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 2, 0, 2),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.login,
                  color: Colors.grey,
                  size: 30.0,
                  semanticLabel: 'Conectar com seu usuário',
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'Entrar',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.grey,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _signInButtonGoogle() {
    return Visibility(
      visible: !signupVisible,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        // ignore: deprecated_member_use
        child: OutlineButton(
          splashColor: Colors.grey,
          onPressed: () {
            showLoadBar();
            signInWithGoogle().then((result) {
              if (result != null) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) {
                      return MainPage();
                    },
                  ),
                );
              } else {
                hideLoadBar();
              }
            }).catchError((e) => hideLoadBar());
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          highlightElevation: 0,
          color: Colors.black,
          highlightedBorderColor: Colors.black,
          highlightColor: Colors.white,
          borderSide: BorderSide(color: Colors.grey[600]),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 3, 0, 3),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image(
                    image: AssetImage("assets/google_logo.png"), height: 25.0),
                Padding(
                  padding: const EdgeInsets.only(left: 2),
                  child: Text(
                    'Entrar com Google',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
