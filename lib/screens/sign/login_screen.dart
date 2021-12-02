import 'package:digital_park/components/container_background.dart';
import 'package:digital_park/components/status_message.dart';
import 'package:digital_park/database/dao/user_settings_dao.dart';
import 'package:digital_park/models/user_settings.dart';
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
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserSettings>(
      future: UserSettingsDao().find(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const StatusMessage(
            errorMessage: 'Digital park',
            loading: true,
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          return TabSignInUp(
            userSettings: snapshot.data ?? UserSettings(1),
          );
        }
        return const StatusMessage(
          errorMessage: 'Ops something are wrong!',
          errorIcon: Icons.warning,
        );
      },
    );
  }
}

class TabSignInUp extends StatefulWidget {
  const TabSignInUp({
    Key? key,
    required this.userSettings,
  }) : super(key: key);

  final UserSettings userSettings;

  @override
  State<TabSignInUp> createState() => _TabSignInUpState();
}

class _TabSignInUpState extends State<TabSignInUp>
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
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: ContainerBackground(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const AppLogo(),
                TabHeader(
                  tabController: _tabController,
                ),
                TabBody(
                  tabController: _tabController,
                  userSettings: widget.userSettings,
                  whenUpdateUserSettings: () {
                    widget.userSettings.staySignIn =
                        !widget.userSettings.staySignIn;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AppLogo extends StatelessWidget {
  const AppLogo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Image.asset(
        'images/logo.png',
        width: double.maxFinite,
        height: 150,
      ),
    );
  }
}

class TabHeader extends StatelessWidget {
  const TabHeader({
    Key? key,
    required TabController tabController,
  })  : _tabController = tabController,
        super(key: key);

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
        unselectedLabelColor: Theme.of(context).secondaryHeaderColor,
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
    );
  }
}

class TabBody extends StatelessWidget {
  const TabBody({
    Key? key,
    required TabController tabController,
    required this.userSettings,
    required this.whenUpdateUserSettings,
  })  : _tabController = tabController,
        super(key: key);

  final TabController _tabController;
  final UserSettings userSettings;
  final Null Function() whenUpdateUserSettings;

  @override
  Widget build(BuildContext context) {
    final Widget controlAccount = ControllerAccount(
      userSettings: userSettings,
      whenUpdate: whenUpdateUserSettings,
    );

    return Expanded(
      child: TabBarView(
        physics: const BouncingScrollPhysics(),
        controller: _tabController,
        children: [
          TabWithScroll(
            child: SignIn(
              controlAccount: controlAccount,
            ),
          ),
          TabWithScroll(
            child: SignUp(
              controlAccount: controlAccount,
            ),
          ),
        ],
      ),
    );
  }
}

class TabWithScroll extends StatelessWidget {
  const TabWithScroll({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 40.0,
          right: 40.0,
          bottom: 16.0,
        ),
        child: child,
      ),
    );
  }
}
