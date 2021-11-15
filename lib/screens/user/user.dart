import 'package:digital_park/components/buttons/background_button.dart';
import 'package:digital_park/components/buttons/label_button.dart';
import 'package:digital_park/components/default_scaffold_app.dart';
import 'package:digital_park/components/inputs/text_input.dart';
import 'package:digital_park/models/user/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserPage extends StatefulWidget {
  const UserPage({
    Key? key,
    required this.userProfile,
  }) : super(key: key);
  final UserProfile userProfile;

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  double sliderValue = 50.0;
  @override
  Widget build(BuildContext context) {
    return DefaultScaffoldApp(
      userProfile: widget.userProfile,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            stretch: true,
            automaticallyImplyLeading: false,
            backgroundColor: Theme.of(context).primaryColor,
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                alignment: Alignment.center,
                color: Theme.of(context).primaryColor,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 3),
                              borderRadius: BorderRadius.circular(50),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 8, // changes position of shadow
                                ),
                              ]),
                          width: 85,
                          height: 85,
                          child: widget.userProfile.photoUrl != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image.network(
                                    widget.userProfile.photoUrl.toString(),
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : null,
                        ),
                        Container(
                          alignment: Alignment.bottomRight,
                          width: 85,
                          height: 85,
                          child: widget.userProfile.providerId == 'google.com'
                              ? Container(
                                  width: 25,
                                  height: 25,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.white),
                                  child: const Icon(
                                    FontAwesomeIcons.google,
                                    size: 18,
                                    color: Colors.redAccent,
                                  ),
                                )
                              : Container(
                                  alignment: Alignment.bottomRight,
                                  width: 85,
                                  height: 85,
                                ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 20),
                    Text(
                      widget.userProfile.username ??
                          widget.userProfile.fullName ??
                          '',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade100,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
              child: Container(
            margin: const EdgeInsets.only(bottom: 70),
            child: FractionallySizedBox(
              widthFactor: 0.9,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Text(
                    widget.userProfile.toString(),
                  ),
                  const SizedBox(height: 20),
                  TextInput(
                    label: 'Nome',
                    controller: TextEditingController(),
                  ),
                  const SizedBox(height: 20),
                  TextInput(
                    controller: TextEditingController(),
                    label: 'E-mail',
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Flexible(
                        flex: 3,
                        child: TextInput(
                          controller: TextEditingController(),
                          label: 'Senha',
                        ),
                      ),
                      const SizedBox(width: 10),
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 1,
                        child: BackgroundButton(
                          onPressed: () {},
                          label: 'Trocar Senha',
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(40),
                    child: LabelButton(
                        fontSize: 15,
                        textAlign: TextAlign.center,
                        textColor: Colors.grey.shade500,
                        label:
                            'Para que são usados os dados preenchidos abaixo?',
                        onPressed: () {}),
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: TextInput(
                          controller: TextEditingController(),
                          label: 'Data de Nascimento',
                        ),
                      ),
                      const SizedBox(width: 10),
                      Flexible(
                        child: TextInput(
                          controller: TextEditingController(),
                          label: 'Sexo',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Gosto mais de praticar',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(color: Colors.grey.shade600, fontSize: 15),
                    ),
                  ),
                  Slider(
                    thumbColor: Theme.of(context).primaryColor,
                    activeColor: Theme.of(context).primaryColor,
                    inactiveColor:
                        Theme.of(context).primaryColor.withOpacity(0.5),
                    value: sliderValue,
                    min: 0,
                    max: 100,
                    divisions: 100,
                    label: 'Arraste',
                    onChanged: (double value) {
                      setState(() {
                        sliderValue = value;
                      });
                    },
                  ),
                  Wrap(
                    children: [
                      FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: 0.5,
                        child: Text(
                          'Esporte',
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                      ),
                      FractionallySizedBox(
                        alignment: Alignment.centerRight,
                        widthFactor: 0.5,
                        child: Text(
                          'Lazer',
                          textAlign: TextAlign.end,
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 30),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Histórico de Compras',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(color: Colors.grey.shade600, fontSize: 15),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    color: Colors.white,
                    child: Table(
                      columnWidths: const <int, TableColumnWidth>{
                        0: FlexColumnWidth(),
                        1: FlexColumnWidth(),
                        2: FlexColumnWidth(),
                      },
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children: const <TableRow>[
                        TableRow(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Produto',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Qtd',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Data e Hora',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          decoration: BoxDecoration(
                            color: Colors.grey,
                          ),
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Lacraia morta',
                                style: TextStyle(fontSize: 13),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                '40',
                                style: TextStyle(fontSize: 13),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                '24/04/2024 às 04:24',
                                style: TextStyle(fontSize: 13),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }
}
