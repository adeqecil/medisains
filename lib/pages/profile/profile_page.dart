import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medisains/helpers/constant_color.dart';
import 'package:medisains/pages/auth/bloc/bloc.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  AuthBloc _authBloc;

  @override
  void initState() {
    // TODO: implement initState
    _authBloc = AuthBloc(InitialAuthState());
    _authBloc.add(ReadUserDataEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      cubit: _authBloc,
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(
            backgroundColor: primaryColor,
            title: Text("User Info"),
          ),
          backgroundColor: Colors.white,
          body: _widgetContentSection(state),
        );
      },
    );
  }

  Widget _widgetContentSection(state){
    return Container(
      margin: EdgeInsets.all(16),
      child: ListView(
        children: <Widget>[
          ListTile(
            title: Text("Username"),
            trailing: Text(
                state is ReadUserDataState
                ? state.username
                : "Username"
            ) ,
          ),
          ListTile(
            title: Text("Email"),
            trailing: Text(
                state is ReadUserDataState
                    ? state.email
                    : "Email"
            ),
          ),
        ],
      ),
    );
  }
}
