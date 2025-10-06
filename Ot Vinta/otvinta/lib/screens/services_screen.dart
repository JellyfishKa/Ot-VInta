import 'package:flutter/material.dart';
import '../models/service_model.dart';

// Cписок услуг, теперь он снова живет здесь
final List<ServiceModel> services = [
  const ServiceModel(title: 'Заявление на ежегодный отпуск', icon: Icons.beach_access),
  const ServiceModel(title: 'Заказ справки 2-НДФЛ', icon: Icons.document_scanner_outlined),
  const ServiceModel(title: 'Запрос на материальную помощь', icon: Icons.attach_money),
  const ServiceModel(title: 'Оформление ДМС для родственника', icon: Icons.medical_services_outlined),
  const ServiceModel(title: 'Заявка на парковочное место', icon: Icons.local_parking_outlined),
];


class ServicesScreen extends StatelessWidget {
  // Этот виджет теперь принимает функцию обратного вызова
  final Function(ServiceModel) onServiceTap;

  const ServicesScreen({super.key, required this.onServiceTap});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: services.length,
      itemBuilder: (context, index) {
        final service = services[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12.0),
          elevation: 2.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            leading: Icon(service.icon, color: Theme.of(context).primaryColor, size: 30),
            title: Text(service.title),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            onTap: () {
              // При нажатии вызываем функцию, которую нам передали "сверху"
              onServiceTap(service);
            },
          ),
        );
      },
    );
  }
}