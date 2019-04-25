import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: MyHomePage(title: 'Demo login page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _userNode = FocusNode();
  final _passwordNode = FocusNode();
  bool _passwordVisibility = false;
  Icon _passworSuffixIcon = Icon(Icons.visibility);

  void _changeVisibility() {
    setState(() {
      _passwordVisibility = !_passwordVisibility;
      _passworSuffixIcon =
          Icon(_passwordVisibility ? Icons.visibility_off : Icons.visibility);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
          color: Colors.deepPurpleAccent.withAlpha(100),
          child: Column(
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(70.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Hero(
                              tag: "hero",
                              child: CircleAvatar(
                                backgroundColor: Colors.deepPurple,
                                radius: 50.0,
                                child: Icon(
                                  Icons.account_circle,
                                  size: 100.0,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: TextFormField(
                                      controller: _usernameController,
                                      focusNode: _userNode,
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        labelText: "Username",
                                        labelStyle: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold),
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 20.0, vertical: 15.0),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0)),
                                      ),
                                      onFieldSubmitted: (value) {
                                        _userNode.unfocus();
                                        FocusScope.of(context)
                                            .requestFocus(_passwordNode);
                                      },
                                      validator: (username) {
                                        if (username.isEmpty)
                                          return "Enter a username";
                                      },
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: TextFormField(
                                      controller: _passwordController,
                                      focusNode: _passwordNode,
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.done,
                                      obscureText: !_passwordVisibility,
                                      decoration: InputDecoration(
                                          labelText: "Password",
                                          labelStyle: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold),
                                          suffixIcon: IconButton(
                                            icon: _passworSuffixIcon,
                                            onPressed: () =>
                                                _changeVisibility(),
                                          ),
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 20.0, vertical: 15.0),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0))),
                                      onFieldSubmitted: (value) => _signIn(
                                          username: _usernameController.text,
                                          password: _passwordController.text),
                                      validator: (password) {
                                        if (password.isEmpty)
                                          return "Enter a password";
                                      },
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: RaisedButton(
                                      child: Text(
                                        "Sign in",
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                      padding: EdgeInsets.all(11.0),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0)),
                                      color: Colors.deepPurple,
                                      onPressed: () => _signIn(
                                          username: _usernameController.text,
                                          password: _passwordController.text),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }

  void _signIn({@required username, @required password}) {
    if (_formKey.currentState.validate()) {
      var _snackBar = SnackBar(
        content: Text(
          "Welcome $username",
          style: TextStyle(
              color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.deepPurpleAccent,
      );
      _scaffoldKey.currentState.showSnackBar(_snackBar);
    }
  }
}
