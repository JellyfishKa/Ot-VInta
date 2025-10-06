import 'package:flutter/material.dart';

class BenefitsScreen extends StatelessWidget {
  const BenefitsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        Card(
          margin: const EdgeInsets.only(bottom: 12.0),
          elevation: 2.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          // Выпадающий список
          child: ExpansionTile(
            leading: Icon(Icons.local_hospital_outlined, color: Theme.of(context).primaryColor),
            title: const Text(
              "Медицинское страхование (ДМС)",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            children: const <Widget>[
              Padding(
                // Отступы для вложенного текста
                padding: EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
                child: Text(
                  "Полис ДМС включает стоматологию, стационарное и амбулаторное лечение. "
                  "Для активации полиса или подключения родственников обратитесь в отдел кадров через сервис 'Задать вопрос HR'.",
                  style: TextStyle(color: Colors.black54),
                ),
              ),
            ],
          ),
        ),
        Card(
          margin: const EdgeInsets.only(bottom: 12.0),
          elevation: 2.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: ExpansionTile(
            leading: Icon(Icons.fitness_center_outlined, color: Theme.of(context).primaryColor),
            title: const Text(
              "Корпоративный спорт",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            children: const <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
                child: Text(
                  "Компания предоставляет скидку 50% на абонементы в сети фитнес-клубов-партнеров. "
                  "Для получения промокода воспользуйтесь сервисом 'Запрос на корпоративную скидку'.",
                  style: TextStyle(color: Colors.black54),
                ),
              ),
            ],
          ),
        ),
        Card(
          margin: const EdgeInsets.only(bottom: 12.0),
          elevation: 2.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: ExpansionTile(
            leading: Icon(Icons.school_outlined, color: Theme.of(context).primaryColor),
            title: const Text(
              "Обучение и развитие",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
             children: const <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
                child: Text(
                  "Каждый сотрудник имеет право на прохождение внешних курсов и конференций за счет компании. "
                  "Годовой бюджет на обучение составляет 50 000 рублей. Подайте заявку через сервис 'Заявка на обучение'.",
                  style: TextStyle(color: Colors.black54),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}