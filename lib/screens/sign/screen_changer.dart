import 'package:digital_park/database/dao/user_settings_dao.dart';
import 'package:digital_park/models/user/user_settings.dart';
import 'package:digital_park/screens/sign/control_account.dart';
import 'package:digital_park/screens/sign/in.dart';
import 'package:digital_park/screens/sign/up.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      vsync: this,
      initialIndex: 0,
      length: 2,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<UserSettings>(
          future: UserSettingsDao().find(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.connectionState == ConnectionState.done) {
              late UserSettings userSettings = snapshot.data ?? UserSettings(1);
              return SafeArea(
                child: SingleChildScrollView(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.top,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'images/background.png',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            'images/logo.png',
                            width: double.maxFinite,
                            height: 150,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 40.0,
                            right: 40.0,
                          ),
                          child: TabBar(
                            controller: _tabController,
                            labelStyle: const TextStyle(
                              fontSize: 24.0,
                            ),
                            labelColor: Theme.of(context).primaryColor,
                            unselectedLabelColor:
                                Theme.of(context).secondaryHeaderColor,
                            tabs: [
                              const Tab(
                                child: SizedBox(
                                  width: double.maxFinite,
                                  child: Text('Entrar'),
                                ),
                              ),
                              Tab(
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  width: double.maxFinite,
                                  child: const Text('Cadastrar'),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 40.0,
                                    right: 40.0,
                                    bottom: 16.0,
                                  ),
                                  child: SignIn(
                                    controlAccount: ControllerAccount(
                                      userSettings: userSettings,
                                      whenUpdate: () {
                                        userSettings.staySignIn =
                                            !userSettings.staySignIn;
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 40.0,
                                    right: 40.0,
                                    bottom: 16.0,
                                  ),
                                  child: SignUp(
                                    controlAccount: ControllerAccount(
                                      userSettings: userSettings,
                                      whenUpdate: () {
                                        userSettings.staySignIn =
                                            !userSettings.staySignIn;
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
            return Text('Ops something are wrong!');
          }),
    );
  }
}
