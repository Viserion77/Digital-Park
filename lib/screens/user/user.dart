import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_park/components/buttons/background_button.dart';
import 'package:digital_park/components/buttons/label_button.dart';
import 'package:digital_park/components/default_scaffold_app.dart';
import 'package:digital_park/components/formater/birth_date.dart';
import 'package:digital_park/components/inputs/text_input.dart';
import 'package:digital_park/models/user_profile.dart';
import 'package:digital_park/provider/firebase_authentication.dart';
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
  @override
  Widget build(BuildContext context) {
    late UserProfile _userProfile = widget.userProfile;
    final TextEditingController userName = TextEditingController(
      text: _userProfile.fullName,
    );
    final TextEditingController userEmail = TextEditingController(
      text: _userProfile.email,
    );
    return DefaultScaffoldApp(
      userProfile: _userProfile,
      body: WillPopScope(
        onWillPop: () async {
          _userProfile.fullName = userName.text.toString();
          FirebaseFirestore.instance
              .collection('users')
              .doc(_userProfile.email)
              .set(_userProfile.toJson());
          return true;
        },
        child: CustomScrollView(
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
                                border:
                                    Border.all(color: Colors.white, width: 3),
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
                            child: _userProfile.photoUrl != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.network(
                                      _userProfile.photoUrl.toString(),
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : null,
                          ),
                          Container(
                            alignment: Alignment.bottomRight,
                            width: 85,
                            height: 85,
                            child: _userProfile.providerId == 'google.com'
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
                        _userProfile.username ?? _userProfile.fullName ?? '',
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
                    TextInput(
                      label: 'Nome',
                      controller: userName,
                    ),
                    const SizedBox(height: 20),
                    TextInput(
                      controller: userEmail,
                      label: 'E-mail',
                      enabled: false,
                    ),
                    const SizedBox(height: 20),
                    _userProfile.providerId == 'password'
                        ? BackgroundButton(
                            onPressed: () {
                              FirebaseAuthenticationProvider()
                                  .passwordResetStandard(
                                email: _userProfile.email,
                              );
                              showDialog(
                                context: context,
                                builder: (context) => const Dialog(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                        'Email enviado com o procedimento da troca da senha!'),
                                  ),
                                ),
                              );
                            },
                            label: 'Trocar Senha',
                          )
                        : Container(),
                    Padding(
                      padding: const EdgeInsets.all(40),
                      child: LabelButton(
                          fontSize: 15,
                          textAlign: TextAlign.center,
                          textColor: Colors.grey.shade500,
                          label:
                              'Para que são usados os dados preenchidos abaixo?',
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => const Dialog(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                      'Os dados abaixo serão usados somente para sua melhor experiencia no aplicativo!'),
                                ),
                              ),
                            );
                          }),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                            child: Flexible(
                              child: Column(
                                children: [
                                  Text('Data Nascimento'),
                                  BirthDate(
                                    _userProfile.birthDate,
                                  ),
                                ],
                              ),
                            ),
                            onTap: () async {
                              final datePick = await showDatePicker(
                                context: context,
                                initialDate: _userProfile.birthDate != null
                                    ? _userProfile.birthDate!.toDate()
                                    : DateTime(2000, 1, 1),
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now(),
                              );
                              if (datePick != null &&
                                  (_userProfile.birthDate == null ||
                                      datePick !=
                                          _userProfile.birthDate!.toDate())) {
                                setState(() {
                                  _userProfile.birthDate =
                                      Timestamp.fromDate(datePick);
                                });
                              }
                            }),
                        const SizedBox(width: 10),
                        Flexible(
                          child: DropdownButton<String>(
                            value: _userProfile.genre == null ||
                                    _userProfile.genre == ''
                                ? 'Genero'
                                : _userProfile.genre,
                            icon: const Icon(Icons.arrow_downward),
                            iconSize: 24,
                            elevation: 16,
                            underline: Container(
                              height: 2,
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                _userProfile.genre = newValue!;
                              });
                            },
                            items: <String>[
                              'Genero',
                              '',
                              'Masculino',
                              'Feminino'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
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
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 15),
                      ),
                    ),
                    Slider(
                      thumbColor: Theme.of(context).primaryColor,
                      activeColor: Theme.of(context).primaryColor,
                      inactiveColor:
                          Theme.of(context).primaryColor.withOpacity(0.5),
                      value: _userProfile.focusActivity != null
                          ? _userProfile.focusActivity! * 100
                          : 50,
                      min: 0,
                      max: 100,
                      divisions: 100,
                      label: 'Arraste',
                      onChanged: (double value) {
                        setState(() {
                          _userProfile.focusActivity = value / 100;
                        });
                      },
                    ),
                    Wrap(
                      children: [
                        FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: 0.5,
                          child: Text(
                            'Lazer',
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                        ),
                        FractionallySizedBox(
                          alignment: Alignment.centerRight,
                          widthFactor: 0.5,
                          child: Text(
                            'Esporte',
                            textAlign: TextAlign.end,
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 30),
                    // Align(
                    //   alignment: Alignment.centerLeft,
                    //   child: Text(
                    //     'Histórico de Compras',
                    //     textAlign: TextAlign.center,
                    //     style:
                    //         TextStyle(color: Colors.grey.shade600, fontSize: 15),
                    //   ),
                    // ),
                    // const SizedBox(height: 10),
                    // Container(
                    //   color: Colors.white,
                    //   child: Table(
                    //     columnWidths: const <int, TableColumnWidth>{
                    //       0: FlexColumnWidth(),
                    //       1: FlexColumnWidth(),
                    //       2: FlexColumnWidth(),
                    //     },
                    //     defaultVerticalAlignment:
                    //         TableCellVerticalAlignment.middle,
                    //     children: const <TableRow>[
                    //       TableRow(
                    //         children: <Widget>[
                    //           Padding(
                    //             padding: EdgeInsets.all(8.0),
                    //             child: Text(
                    //               'Produto',
                    //               style: TextStyle(fontWeight: FontWeight.bold),
                    //             ),
                    //           ),
                    //           Padding(
                    //             padding: EdgeInsets.all(8.0),
                    //             child: Text(
                    //               'Qtd',
                    //               style: TextStyle(fontWeight: FontWeight.bold),
                    //             ),
                    //           ),
                    //           Padding(
                    //             padding: EdgeInsets.all(8.0),
                    //             child: Text(
                    //               'Data e Hora',
                    //               style: TextStyle(fontWeight: FontWeight.bold),
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //       TableRow(
                    //         decoration: BoxDecoration(
                    //           color: Colors.grey,
                    //         ),
                    //         children: <Widget>[
                    //           Padding(
                    //             padding: EdgeInsets.all(8.0),
                    //             child: Text(
                    //               'Lacraia morta',
                    //               style: TextStyle(fontSize: 13),
                    //             ),
                    //           ),
                    //           Padding(
                    //             padding: EdgeInsets.all(8.0),
                    //             child: Text(
                    //               '40',
                    //               style: TextStyle(fontSize: 13),
                    //             ),
                    //           ),
                    //           Padding(
                    //             padding: EdgeInsets.all(8.0),
                    //             child: Text(
                    //               '24/04/2024 às 04:24',
                    //               style: TextStyle(fontSize: 13),
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
