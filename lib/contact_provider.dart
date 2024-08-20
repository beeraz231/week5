import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:my_contact/contact.dart';

class ContactProvider extends ChangeNotifier {
  static int _lastId = 6;
  final List<Contact> _items = [
    Contact(
        id: 1,
        name: 'Contact1',
        phone: '0888888888',
        email: 'contact1@gmail.com'),
    Contact(
        id: 2,
        name: 'Contact2',
        phone: '0888888888',
        email: 'contact2@gmail.com'),
    Contact(
        id: 3,
        name: 'Contact3',
        phone: '0888888888',
        email: 'contact3@gmail.com'),
    Contact(
        id: 4,
        name: 'Contact4',
        phone: '0888888888',
        email: 'contact4@gmail.com'),
    Contact(
        id: 5,
        name: 'Contact5',
        phone: '0888888888',
        email: 'contact5@gmail.com'),
  ];
  Contact _currentContact = Contact(id: -1, name: '', email: '', phone: '');
  UnmodifiableListView<Contact> get items => UnmodifiableListView(_items);
  Contact get currentContact => _currentContact;
  void setCurrentContact(Contact? contact) {
    if (contact == null) {
      _currentContact = Contact(id: -1, name: '', email: '', phone: '');
    } else {
      _currentContact = Contact(
          id: contact.id,
          name: contact.name,
          email: contact.email,
          phone: contact.phone);
    }
    notifyListeners();
  }

  void saveContact() {
    if (_currentContact.id < 0) {
      _items.add(_currentContact.copyWith(id: _lastId++));
      // _items.add(Contact(
      //     id: _lastId++,
      //     name: _currentContact.name,
      //     phone: _currentContact.phone,
      //     email: _currentContact.email));
    } else {
      int index = _items.indexWhere((c) => c.id == _currentContact.id);
      if (index != -1) {
        _items[index] = _currentContact.copyWith();
        // _items[index] = Contact(
        //     id: _currentContact.id,
        //     name: _currentContact.name,
        //     phone: _currentContact.phone,
        //     email: _currentContact.email);
      }
    }
    notifyListeners();
  }

  void deleteContact(int index) {
    if (index != -1) {
      _items.removeAt(index);
    }
    notifyListeners();
  }
}
