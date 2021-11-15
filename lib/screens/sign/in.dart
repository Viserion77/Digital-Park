import 'package:digital_park/components/buttons/background_button.dart';
import 'package:digital_park/components/buttons/fa_button.dart';
import 'package:digital_park/components/inputs/text_input.dart';
import 'package:digital_park/components/miscellaneous/dialog_message.dart';
import 'package:digital_park/provider/firebase_authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  const SignIn({
    Key? key,
    required this.controlAccount,
  }) : super(key: key);
  final Widget controlAccount;

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  String _errorEmail = '';
  String _errorPassWord = '';
  bool _onLoadingStandard = false;
  bool _onLoadingGoogle = false;
  bool _onLoadingAnonymously = false;

  @override
  void dispose() {
    _controllerEmail.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        children: [
          TextInput(
            label: 'E-mail',
            controller: _controllerEmail,
            errorText: _errorEmail,
          ),
          const SizedBox(height: 16.0),
          TextInput(
            label: 'Senha',
            obscureText: true,
            controller: _controllerPassword,
            errorText: _errorPassWord,
          ),
          widget.controlAccount,
          BackgroundButton(
            label: 'Entrar',
            onLoading: _onLoadingStandard,
            onPressed: () => signIn(context),
          ),
          const SizedBox(height: 16.0),
          FaButton(
            label: 'Entrar com o Google',
            color: Colors.white,
            fontColor: Colors.red,
            onLoading: _onLoadingGoogle,
            onPressed: () => joinWithGoogle(context),
            icon: const FaIcon(
              FontAwesomeIcons.google,
              color: Colors.red,
            ),
          ),
          const SizedBox(height: 16.0),
          BackgroundButton(
            label: 'Pular',
            onLoading: _onLoadingAnonymously,
            onPressed: () => joinLikeAnonymously(context),
          ),
        ],
      ),
    );
  }

  void joinLikeAnonymously(BuildContext context) {
    setState(() {
      _onLoadingAnonymously = true;
    });
    final provider = Provider.of<FirebaseAuthenticationProvider>(
      context,
      listen: false,
    );
    provider.loginAnonymously();
  }

  void joinWithGoogle(BuildContext context) {
    setState(() {
      _onLoadingGoogle = true;
    });
    try {
      final provider = Provider.of<FirebaseAuthenticationProvider>(
        context,
        listen: false,
      );
      provider.loginWithGoogle();
    } catch (error) {
      setState(() {
        _onLoadingGoogle = false;
      });
    }
  }

  void signIn(BuildContext context) {
    setState(() {
      _onLoadingStandard = true;
    });
    if (_controllerEmail.text != "" && _controllerPassword.text != "") {
      final provider = Provider.of<FirebaseAuthenticationProvider>(
        context,
        listen: false,
      );
      try {
        provider.signInStandard(
          email: _controllerEmail.text,
          password: _controllerPassword.text,
        );
      } catch (error) {
        showDialog(
          context: context,
          builder: (context) => DialogMessage(
            error.toString(),
          ),
        );
        setState(() {
          _onLoadingStandard = false;
        });
      }
    } else {
      setState(
        () {
          if (_controllerEmail.text.isEmpty) {
            _errorEmail = 'Insira um e-mail valido!';
          }
          if (_controllerPassword.text.isEmpty) {
            _errorPassWord = 'Insira uma senha!';
          }
        },
      );
      setState(() {
        _onLoadingStandard = false;
      });
    }
  }
}
