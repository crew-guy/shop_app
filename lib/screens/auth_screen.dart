import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/http_exception.dart';
import 'package:shop_app/providers/auth.dart';

enum AuthMode { Signup, Login }

class AuthScreen extends StatelessWidget {
  static const routeName = "/auth";

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(67, 66, 78, 1).withOpacity(0.5),
                  Color.fromRGBO(89, 103, 122, 1).withOpacity(0.5),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomCenter,
                stops: [0, 1],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(20.0),
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Container(
                        margin: EdgeInsets.only(bottom: 20.0),
                        padding: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 94.0),
                        transform: Matrix4.rotationZ(-8 * pi / 180)
                          ..translate(-10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 8,
                              color: Colors.black26,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Text(
                          'Pro Shop',
                          style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.normal,
                            fontSize: 40.0,
                            color:
                                Theme.of(context).accentTextTheme.title?.color,
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: deviceSize.width > 600 ? 2 : 1,
                      child: AuthCard(),
                    )
                  ]),
            ),
          )
        ],
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({Key? key}) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  bool _isLoading = false;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  final _passwordController = TextEditingController();
  AnimationController? _controller;
  Animation<Size>? _heightAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 300,
      ),
    );
    _heightAnimation = Tween<Size>(
            begin: Size(double.infinity, 260), end: Size(double.infinity, 320))
        .animate(
      CurvedAnimation(parent: _controller!, curve: Curves.linear),
    );
    // _heightAnimation?.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller!.dispose();
  }

  void _showErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Authentication error'),
        content: Text(errorMessage),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Okay'))
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      // Invalid
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (_authMode == AuthMode.Login) {
        // Log user in
        await Provider.of<Auth>(context, listen: false).signin(
          _authData['email']!,
          _authData['password']!,
        );
      } else {
        // Sign user up
        await Provider.of<Auth>(context, listen: false).signup(
          _authData['email']!,
          _authData['password']!,
        );
      }
    } on HttpException catch (error) {
      print('http ex err');
      var errorMessage = "Failed to authenticate you.";
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = "A user with this email already exists";
      } else if (errorMessage.toString().contains('INVALID_EMAIL')) {
        errorMessage = "Entered email is invalid";
      } else if (errorMessage.toString().contains('INVALID_PASSWORD')) {
        errorMessage = "Entered password is invalid";
      } else if (errorMessage.toString().contains('WEAK_PASSWORD')) {
        errorMessage = "Entered password is weak";
      } else if (errorMessage.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = "There is no user with this email";
      } else {
        errorMessage = "eh";
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      var errorMessage = "Your authentication failed....";
      _showErrorDialog(errorMessage);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
      _controller!.forward();
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
      _controller!.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 8.0,
      child: AnimatedBuilder(
        animation: _heightAnimation!,
        builder: (ctx, ch) => Container(
            height: _heightAnimation!.value.height,
            constraints: BoxConstraints(
              minHeight: _heightAnimation!.value.height,
            ),
            width: deviceSize.width * 0.75,
            padding: EdgeInsets.all(16.0),
            child: ch),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Enter email address'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Invalid email';
                    }
                    ;
                  },
                  onSaved: (value) {
                    _authData['email'] = value!;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password'),
                  controller: _passwordController,
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty || value.length < 5) {
                      return 'Password is too short';
                    }
                  },
                  onSaved: (value) {
                    _authData['password'] = value!;
                  },
                ),
                if (_authMode == AuthMode.Signup)
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Password confirm'),
                    enabled: _authMode == AuthMode.Signup,
                    obscureText: true,
                    validator: _authMode == AuthMode.Signup
                        ? (value) {
                            if (value != _passwordController.text) {
                              return 'Passwords do not match';
                            }
                          }
                        : null,
                  ),
                SizedBox(height: 20),
                if (_isLoading)
                  CircularProgressIndicator()
                else
                  RaisedButton(
                    child:
                        Text(_authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP'),
                    onPressed: _submit,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 4.0),
                    color: Theme.of(context).primaryColor,
                    textColor: Theme.of(context).primaryTextTheme.button?.color,
                  ),
                FlatButton(
                    child: Text(
                        '${_authMode == AuthMode.Login ? 'SIGNUP' : 'LOGIN'} INSTEAD'),
                    onPressed: _switchAuthMode,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    textColor: Theme.of(context).primaryColor)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
