import 'dart:math';
import 'package:flutter/material.dart';
import 'package:my_contact/add_contact_widget.dart';
import 'package:my_contact/contact.dart';
import 'package:my_contact/contact_provider.dart';
import 'package:my_contact/edit_contact_widget.dart';
import 'package:provider/provider.dart';

class ContactWidget extends StatefulWidget {
  const ContactWidget({Key? key}) : super(key: key);

  @override
  _ContactWidgetState createState() => _ContactWidgetState();
}

class _ContactWidgetState extends State<ContactWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ContactProvider>(
      builder: (context, contactProvider, child) {
        return DefaultTabController(
          length: 3,
          initialIndex: 1,
          child: Scaffold(
            appBar: AppBar(
              title: Text('My Contact'),
              bottom: TabBar(tabs: <Widget>[
                Tab(icon: Icon(Icons.cloud_outlined)),
                Tab(icon: Icon(Icons.card_giftcard)),
              ]),
            ),
            body: TabBarView(
              children: [
                ContactListView1(),
                ContactListView2(),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return AddContactWidget();
                }));
              },
            ),
          ),
        );
      },
    );
  }
}

class ContactListView1 extends StatelessWidget {
  const ContactListView1({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ContactProvider>(
        builder: (context, contactProvider, child) {
      return ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              child: Text(contactProvider.items[index].name[0]),
            ),
            title: Text(
              contactProvider.items[index].name,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  contactProvider.items[index].phone,
                ),
                Text(
                  contactProvider.items[index].email,
                ),
              ],
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Delete Contact'),
                      content:
                          Text('Are you sure you want to delete this contact'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            Provider.of<ContactProvider>(context, listen: false)
                                .deleteContact(index);
                            Navigator.pop(context);
                          },
                          child: Text('Delete'),
                        )
                      ],
                    );
                  },
                );
              },
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  final provider =
                      Provider.of<ContactProvider>(context, listen: false);
                  provider.setCurrentContact(provider.items[index]);
                  return EditContactWidget();
                },
              ));
            },
          );
        },
        itemCount: contactProvider.items.length,
      );
    });
  }
}

class ContactListView2 extends StatelessWidget {
  const ContactListView2({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // List of emojis to choose from
    final emojis = [
      '😀', '😎', '🤩', '😍', '🧐', 
      '🤓', '😇', '🧙‍♂️', '🦸‍♀️', '👨‍🚀',
    ];

    return Consumer<ContactProvider>(
      builder: (context, contactProvider, child) {
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, 
          ),
          itemCount: contactProvider.items.length,
          itemBuilder: (context, index) {
            final contact = contactProvider.items[index];
            final randomEmoji = emojis[Random().nextInt(emojis.length)]; // Randomly select an emoji

            return Card(
              color: Colors.blueGrey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          child: Text(randomEmoji),
                          backgroundColor: Color.fromARGB(255, 18, 19, 62),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete,
                              color: Color.fromARGB(255, 224, 89, 76)),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Delete Contact'),
                                  content: const Text(
                                      'Are you sure you want to delete this contact?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Provider.of<ContactProvider>(context,
                                                listen: false)
                                            .deleteContact(index);
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Delete'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      contact.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      contact.phone,
                      style: const TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      contact.email,
                      style: const TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
