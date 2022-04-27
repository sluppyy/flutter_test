import 'package:flutter/material.dart';
import 'package:startup_namer/legacy/User.dart';

class ProfileScreen extends StatefulWidget {
  final User user;
  final void Function(User) onSaveUser;

  const ProfileScreen({Key? key,
    required this.user,
    required this.onSaveUser
  }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _editing = false;
  final name_controller = TextEditingController();
  final about_controler  = TextEditingController();
  final phone_controller = TextEditingController();
  final email_controller = TextEditingController();

  void _setEditMod(bool isEditing) {
    setState(() {
      _editing = isEditing;
    });
  }

  @override void initState() {
    super.initState();

    name_controller.text = widget.user.name;
    about_controler.text = widget.user.about;
    phone_controller.text = widget.user.phoneNumber;
    email_controller.text = widget.user.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0x00ffffff),
        appBar: AppBar(centerTitle: true, elevation: 0, title: const Text("Profile")),
        body: !_editing
            ? ListView(children: [
          Stack(children: [Padding(padding: const EdgeInsets.all(20),
              child: UserInfo(user: widget.user)),
            Align(
                alignment: Alignment.bottomRight,
                child: IconButton(icon: const Icon(Icons.edit, color: Colors.white),
                    onPressed: (){_setEditMod(true);},
                    iconSize: 40)
            )
          ]),

          Padding(
              padding: const EdgeInsets.all(20),
              child: BorderWithInfo(
                borderWidth: 1,
                title: WhiteText(text: "About", fontSize: 30),
                info: SizedBox(width: double.infinity, child: WhiteText(
                    text: widget.user.about.isNotEmpty
                        ? widget.user.about
                        : "Empty",
                    fontSize: 30)),
                padding: 00, margin: 5)
          ),

          ...mapWidgets(
              widgets: [
                WhiteText(text: "  Phone: " + widget.user.phoneNumber, fontSize: 30),
                WhiteText(text: "  Email:  " + widget.user.email, fontSize: 30),
              ],
              mapper: (text) {
                return Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(padding: const EdgeInsets.fromLTRB(10, 10, 0, 0), child: text)
                );
              }
          ),
        ])
            : Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: ListView(children: [
            SizedBox(
                height: 120,
                child: EditableUserInfo(user: widget.user, controller: name_controller)
            ),

            SizedBox(
                height: 250,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: BorderWithInfo(
                    margin: 5,
                      title: Padding(child: WhiteText(text: "About", fontSize: 20), padding: const EdgeInsets.all(20)),
                      info: TextField(
                        style: const TextStyle(color: Colors.white, fontSize: 18),
                        maxLines: 6,
                        controller: about_controler,
                        decoration: const InputDecoration(
                        ),
                      )
                  ),
                )
            ),

            ...mapWidgets(
                widgets: [
                  SizedBox(
                      height: 50,
                      child: TextField(
                        controller: phone_controller,
                        cursorColor: Colors.white,
                        style: const TextStyle(color: Colors.white, fontSize: 20),
                        decoration: const InputDecoration(
                          labelStyle: TextStyle(color: Colors.white),
                          labelText: "Phone",
                        ),
                      )
                  ),
                  SizedBox(
                      height: 50,
                      child: TextField(
                        controller: email_controller,
                        cursorColor: Colors.white,
                        style: const TextStyle(color: Colors.white, fontSize: 20),
                        decoration: const InputDecoration(
                          labelStyle: TextStyle(color: Colors.white),
                          labelText: "Email",
                        ),
                      )
                  )
                ],
                mapper: (w){return Padding(padding: const EdgeInsets.fromLTRB(0, 20, 0, 0), child: w);}
            ),

            Expanded(child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                    child: IconButton(icon: const Icon(Icons.save, color: Colors.white), onPressed: (){
                      widget.onSaveUser(
                        User(
                            name: name_controller.text,
                            email: email_controller.text,
                            phoneNumber: phone_controller.text,
                            about: about_controler.text,
                            profileSrc: widget.user.profileSrc,
                            id: widget.user.id,
                            bearer: widget.user.bearer)
                      );
                      _setEditMod(false);}, iconSize: 40)
                ))),
          ]),
        )
    );
  }
}

Widget WhiteText({required String text, required double fontSize}) {
  return Text(text, style: TextStyle(color: Colors.white, fontSize: fontSize));
}

class BorderWithInfo extends StatelessWidget {
  final Widget title;
  final Widget info;
  final Color color;
  final double borderWidth;
  final double margin;
  final double padding;

  const BorderWithInfo({Key? key,
    required this.title,
    required this.info,
             this.color = Colors.white,
             this.borderWidth = 1,
             this.margin = 0,
             this.padding = 0
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title,
          Padding(
            padding: EdgeInsets.all(padding),
            child: Container(
                child: Padding(
                  padding: EdgeInsets.all(margin),
                  child: info
                ),
                decoration: BoxDecoration(border: Border.all(
                    color: color,
                    width: borderWidth)
                )
            )
          )
        ]);
  }
}

class UserInfo extends StatelessWidget {
  final User user;

  const UserInfo({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      user.profileSrc.isNotEmpty
          ? CircleAvatar(backgroundImage: AssetImage(user.profileSrc), radius: 60, backgroundColor: const Color(0x00ffffff))
          : const Icon(Icons.person, color: Colors.white, size: 120),

      Padding(padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
        child: Text(user.name, style: const TextStyle(color: Colors.white, fontSize: 40))),
    ]);
  }
}

class EditableUserInfo extends StatelessWidget {
  final User user;
  final TextEditingController controller;

  const EditableUserInfo({Key? key,
    required this.user,
    required this.controller
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      user.profileSrc.isNotEmpty
          ? Stack(children: [
            CircleAvatar(backgroundImage: AssetImage(user.profileSrc), radius: 60, backgroundColor: const Color(0x00ffffff)),
            SizedBox(width: 120, height: 120, child: Center(child: IconButton(icon: const Icon(Icons.add_photo_alternate_outlined), color: Colors.white, iconSize: 30, onPressed: () {  },)))
      ])
          : const Icon(Icons.person, color: Colors.white, size: 120),

      Expanded(child: Padding(padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
          child: SizedBox(
              height: 50,
              child: TextField(
                cursorColor: Colors.white,
                style: const TextStyle(color: Colors.white, fontSize: 20),
                controller: controller,
                decoration: const InputDecoration(
                  labelStyle: TextStyle(color: Colors.white),
                    labelText: "Name",
                ),
              )
          )))
    ]);
  }
}



List<Widget> mapWidgets({
  required List<Widget> widgets,
  required Widget Function(Widget) mapper
}) {
  final List<Widget> result = [];

  for (Widget widget in widgets) {result.add(mapper(widget));}

  return result;
}