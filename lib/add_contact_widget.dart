import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_contact/contact.dart';
import 'package:my_contact/contact_provider.dart';
import 'package:provider/provider.dart';

class AddContactWidget extends StatefulWidget {
  const AddContactWidget({Key? key}) : super(key: key);
  @override
  _AddContactWidgetState createState() => _AddContactWidgetState();
}

class _AddContactWidgetState extends State<AddContactWidget> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController nameConTroller;
  late TextEditingController phoneConTroller;
  late TextEditingController emailConTroller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameConTroller = TextEditingController();
    phoneConTroller = TextEditingController();
    emailConTroller = TextEditingController();
  }

  @override
  void dispose() {
    nameConTroller.dispose();
    phoneConTroller.dispose();
    emailConTroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Add New Contact'),
          ),
          body: Form(
              key: _formKey,
              child: ListView(padding: EdgeInsets.all(16), children: [
                TextFormField(
                  controller: nameConTroller,
                  decoration: InputDecoration(
                      labelText: 'Name', border: OutlineInputBorder()),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter name text';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: phoneConTroller,
                  decoration: InputDecoration(
                      labelText: 'Phone', border: OutlineInputBorder()),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter phone ';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: emailConTroller,
                  decoration: InputDecoration(
                      labelText: 'Email', border: OutlineInputBorder()),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter email ';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.pop(context);
                        final provider = Provider.of<ContactProvider>(context,
                            listen: false);
                        provider.setCurrentContact(Contact(
                            id: -1,
                            name: nameConTroller.text,
                            phone: phoneConTroller.text,
                            email: emailConTroller.text));
                        provider.saveContact();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Process Data'),
                        ));
                      }
                    },
                    child: Text('Add contact'))
              ])),
        );
      },
    );
  }
}
