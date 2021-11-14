import 'package:digital_park/components/buttons/background_button.dart';
import 'package:digital_park/components/buttons/fa_button.dart';
import 'package:digital_park/components/inputs/text_input.dart';
import 'package:digital_park/provider/firebase_authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({
    Key? key,
    required this.controlAccount,
  }) : super(key: key);
  final Widget controlAccount;

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignUp> {
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerConfirmPassword =
      TextEditingController();
  String _errorEmail = '';
  String _errorPassWord = '';
  String _errorConfirmPassWord = '';
  bool _onLoadingStandard = false;
  bool _onLoadingGoogle = false;
  bool _onLoadingAnonymously = false;

  @override
  void dispose() {
    _controllerEmail.dispose();
    _controllerPassword.dispose();
    _controllerConfirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: TextInput(
              label: 'E-mail',
              controller: _controllerEmail,
              errorText: _errorEmail,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: TextInput(
              label: 'Senha',
              obscureText: true,
              controller: _controllerPassword,
              errorText: _errorPassWord,
            ),
          ),
          TextInput(
            label: 'Confirmar senha',
            obscureText: true,
            controller: _controllerConfirmPassword,
            errorText: _errorConfirmPassWord,
          ),
          widget.controlAccount,
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: BackgroundButton(
              onLoading: _onLoadingStandard,
              onPressed: () {
                setState(() {
                  _onLoadingStandard = true;
                });
                createAccount(context);
              },
              label: 'Cadastrar',
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: FaButton(
              color: Colors.white,
              fontColor: Colors.red,
              label: 'Cadastrar com o Google',
              icon: const FaIcon(
                FontAwesomeIcons.google,
                color: Colors.red,
              ),
              onLoading: _onLoadingGoogle,
              onPressed: () {
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
              },
            ),
          ),
          BackgroundButton(
            onLoading: _onLoadingAnonymously,
            onPressed: () {
              setState(() {
                _onLoadingAnonymously = true;
              });
              final provider = Provider.of<FirebaseAuthenticationProvider>(
                context,
                listen: false,
              );
              provider.loginAnonymously();
            },
            label: 'Pular',
          ),
        ],
      ),
    );
  }

  void createAccount(BuildContext context) {
    if (_controllerEmail.text != "" && _controllerPassword.text != "") {
      try {
        final provider = Provider.of<FirebaseAuthenticationProvider>(
          context,
          listen: false,
        );
        provider.signUpStandard(
          email: _controllerEmail.text,
          password: _controllerPassword.text,
        );
      } on Exception catch (e) {
        print('Exception ${e.toString()}');
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
          if (_controllerConfirmPassword.text.isEmpty) {
            _errorConfirmPassWord = 'Senha não é coerente!';
          }
        },
      );
      setState(() {
        _onLoadingStandard = false;
      });
    }
  }
}
