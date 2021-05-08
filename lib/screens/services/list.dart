import 'package:digital_park/components/bottom_menu_bar.dart';
import 'package:digital_park/models/service.dart';
import 'package:flutter/material.dart';

class ServicesList extends StatelessWidget {
  final List<Service> services = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) {
          final Service event = services[index];
          return _ServiceItem(event);
        },
        itemCount: services.length,
      ),
      bottomNavigationBar: BottomMenuBar(),
    );
  }
}

class _ServiceItem extends StatelessWidget {
  final Service service;

  _ServiceItem(this.service);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          service.name,
          style: TextStyle(
            fontSize: 24,
          ),
        ),
        subtitle: Text(
          service.numero.toString(),
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
