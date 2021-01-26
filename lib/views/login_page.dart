import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  // Colors.orange[900],
                  // Colors.orange[800],
                  Colors.orange[700],
                  Colors.orange[600],
                  // Colors.orange,
                ],
                stops: [
                  // 0.1,
                  // 0.2,
                  0.1,
                  0.6,
                  // 0.9,
                ]),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'eMatch',
                  style: TextStyle(
                    fontSize: 30.0,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),
                Card(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.orange,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                              icon: Icon(Icons.person),
                              labelText: 'Usuario/email',
                            ),
                            validator: (value) {
                              return null;
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              icon: Icon(Icons.lock),
                              labelText: 'Senha',
                            ),
                            validator: (value) {
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/home');
                    },
                    child: Text('Entrar'),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    RaisedButton(
                      child: Text('F'),
                      onPressed: () {},
                    ),
                    RaisedButton(
                      child: Text('G'),
                      onPressed: () {},
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
