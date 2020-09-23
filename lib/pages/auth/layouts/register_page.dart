import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medisains/helpers/constant_color.dart';
import 'package:medisains/helpers/toast_helper.dart';
import 'package:medisains/helpers/validator_helper.dart';
import 'package:medisains/pages/auth/bloc/bloc.dart';
import 'package:medisains/pages/auth/layouts/login_page.dart';
import 'package:medisains/pages/home/home_page.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool hidePassword = true;
  bool hideConfPassword = true;
  AuthBloc _authBloc;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    _authBloc = AuthBloc(InitialAuthState());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      cubit: _authBloc,
      listener: (context,state){
        if(state is RegisterState)
          Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()));
        else if(state is AuthErrorState)
          ToastHelper.showFlutterToast(state.msg);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: _widgetContentSection(),
        bottomNavigationBar: _widgetFooterSection(),
      ),
    );
  }

  Widget _widgetContentSection() {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(vertical: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Welcome Back,",
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 28)),
                    Text("Register To Create Account",
                        style: TextStyle(color: disableTextGreyColor, fontSize: 20)),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: TextFormField(
                        controller: _usernameController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: "Username",
                          hintText: "Your Username",
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: primaryColor),
                          ),
                          labelStyle: TextStyle(color: Colors.black, fontSize: 16.0),
                        ),
                        validator: (String value) => ValidatorHelper.validatorUsername(value: value,label: "Username"),
                      ),
                    ),
                    Container(
                      child: TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (String value) => ValidatorHelper.validateEmail(value: value),
                        decoration: InputDecoration(
                          labelText: "Email",
                          hintText: "Your Email",
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: primaryColor),
                          ),
                          labelStyle: TextStyle(color: Colors.black, fontSize: 16.0),
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: _passwordController,
                      keyboardType: TextInputType.text,
                      obscureText: hidePassword,
                      validator: (String value) => ValidatorHelper.validatorPassword(value: value,label: "Password"),
                      decoration: InputDecoration(
                          labelText: "Password",
                          hintText: "Your Password",
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: primaryColor),
                          ),
                          labelStyle: TextStyle(color: Colors.black, fontSize: 16.0),
                          suffixIcon: IconButton(
                              icon: Icon(!hidePassword ? Icons.visibility : Icons.visibility_off, color: primaryColor),
                              onPressed: () {
                                setState(() {
                                  hidePassword = !hidePassword;
                                });
                              })),
                    ),
                    TextFormField(
                      controller: _confirmPasswordController,
                      keyboardType: TextInputType.text,
                      obscureText: hideConfPassword,
                      validator: (String value) => ValidatorHelper.validatorPassword(value: value,label: "Konfirmasi Password"),
                      decoration: InputDecoration(
                          labelText: "Confirm Password",
                          hintText: "Your Password",
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: primaryColor),
                          ),
                          labelStyle: TextStyle(color: Colors.black, fontSize: 16.0),
                          suffixIcon: IconButton(
                              icon: Icon(!hideConfPassword ? Icons.visibility : Icons.visibility_off, color: primaryColor),
                              onPressed: () {
                                setState(() {
                                  hideConfPassword = !hideConfPassword;
                                });
                              })),
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: FlatButton(
                  padding: EdgeInsets.all(16),
                  onPressed: () => _register(),
                  color: primaryColor,
                  child: Text(
                    "REGISTER",
                    style: TextStyle(color: Colors.white),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4), side: BorderSide(color: primaryColor)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _widgetFooterSection(){
    return Container(
      padding: EdgeInsets.all(16),
      child: GestureDetector(
        onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage())),
        child: Text("Already have an account ? Login",
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center),
      ),
    );
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (value.isEmpty)
      return 'Email Tidak Boleh Kosong';
    else if (!regex.hasMatch(value))
      return 'Masukkan Email yang valid';
    else
      return null;
  }

  _register() {
    if(_confirmPasswordController.text != _passwordController.text)
      ToastHelper.showFlutterToast("Konfirmasi password harus sama dengan password");
    else if(_formKey.currentState.validate())
      _authBloc.add(RegisterEvent(
          email: _emailController.text,
          password: _passwordController.text,
          username: _usernameController.text
      ));
  }

  _navigateToLogin() {
    Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginPage()));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

}