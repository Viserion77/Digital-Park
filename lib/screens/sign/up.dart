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
          const SizedBox(height: 16.0),
          TextInput(
            label: 'Confirmar senha',
            obscureText: true,
            controller: _controllerConfirmPassword,
            errorText: _errorConfirmPassWord,
          ),
          widget.controlAccount,
          BackgroundButton(
            onLoading: _onLoadingStandard,
            label: 'Cadastrar',
            onPressed: () => createAccount(context),
          ),
          const SizedBox(height: 16.0),
          FaButton(
            label: 'Cadastrar com o Google',
            color: Colors.white,
            fontColor: Colors.red,
            onLoading: _onLoadingGoogle,
            onPressed: () => loginWithGoogle(context),
            icon: const FaIcon(
              FontAwesomeIcons.google,
              color: Colors.red,
            ),
          ),
          const SizedBox(height: 16.0),
          BackgroundButton(
            label: 'Pular',
            onLoading: _onLoadingAnonymously,
            onPressed: () => loginLikeAnonymously(context),
          ),
        ],
      ),
    );
  }

  void loginLikeAnonymously(BuildContext context) {
    setState(() {
      _onLoadingAnonymously = true;
    });
    final provider = Provider.of<FirebaseAuthenticationProvider>(
      context,
      listen: false,
    );
    provider.loginAnonymously();
  }

  void loginWithGoogle(BuildContext context) {
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

  void createAccount(BuildContext context) {
    setState(() {
      _onLoadingStandard = true;
    });
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
