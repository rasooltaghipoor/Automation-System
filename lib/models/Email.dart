import 'package:flutter/material.dart';

class Email {
  final String? name, image, source, subject, body, time,type, requiredAction, idNumber;
  final bool? isAttachmentAvailable, isChecked, isSelected, isOriginal, isConfidential;
  final Color? tagColor;

  Email({
    this.name,
    this.image,
    this.source,
    this.subject,
    this.body,
    this.time,
    this.type,
    this.requiredAction,
    this.idNumber,
    this.isAttachmentAvailable,
    this.isChecked,
    this.isSelected,
    this.isOriginal,
    this.isConfidential,
    this.tagColor,
  });
}

List<Email> emails = List.generate(
  demo_data.length,
  (index) => Email(
    name: demo_data[index]['name'],
    image: demo_data[index]['image'],
    source: demo_data[index]['source'],
    subject: demo_data[index]['subject'],
    body: emailDemoText,
    time: demo_data[index]['time'],
    type: demo_data[index]['type'],
    requiredAction: demo_data[index]['requiredAction'],
    idNumber: demo_data[index]['idNumber'],
    isAttachmentAvailable: demo_data[index]['isAttachmentAvailable'],
    isChecked: demo_data[index]['isChecked'],
    isSelected: demo_data[index]['isSelected'],
    isOriginal: demo_data[index]['isOriginal'],
    isConfidential: demo_data[index]['isConfidential'],
    tagColor: demo_data[index]['tagColor'],
  ),
);

List demo_data = [
  {
    "name": "مدیر فنی",
    "image": "assets/images/user_1.png",
    "source": "اداری",
    "subject": "تقاضای تجهیزات",
    "time": "Now",
    "type": 'وارده',
    "requiredAction": 'اقدام',
    "idNumber": '112/سب/۴۴۵۶',
    "isAttachmentAvailable": false,
    "isChecked": true,
    "isSelected": false,
    "isOriginal": false,
    "isConfidential": false,
    "tagColor": null,
  },
  {
    "name": "ریاست",
    "image": "assets/images/user_2.png",
    "source": "اداری",
    "subject": "تقاضای تجهیزات",
    "time": "15:32",
    "type": 'وارده',
    "requiredAction": 'اقدام',
    "idNumber": '112/سب/۴۴۵۶',
    "isAttachmentAvailable": true,
    "isChecked": true,
    "isSelected": false,
    "isOriginal": true,
    "isConfidential": true,
    "tagColor": null,
  },
  {
    "name": "محمد لکزیان",
    "image": "assets/images/user_3.png",
    "source": "ریاست",
    "subject": "درخواست وام بدون بهره",
    "time": "15:32",
    "type": 'وارده',
    "requiredAction": 'اقدام',
    "idNumber": '112/سب/۴۴۵۶',
    "isAttachmentAvailable": true,
    "isChecked": false,
    "isSelected": false,
    "isOriginal": false,
    "isConfidential": false,
    "tagColor": null,
  },
  {
    "name": "علی علی زاده",
    "image": "assets/images/user_4.png",
    "source": "امور کلاس ها",
    "subject": "فراغت از تحصیل",
    "time": "15:32",
    "type": 'صادره',
    "requiredAction": 'امضا',
    "idNumber": '112/سب/۴۴۵۶',
    "isAttachmentAvailable": false,
    "isChecked": true,
    "isSelected": false,
    "isOriginal": false,
    "isConfidential": true,
    "tagColor": Color(0xFF23CF91),
  },
  {
    "name": "محسن تقی زاده",
    "image": "assets/images/user_4.png",
    "source": "اداری",
    "subject": "پول می خوام",
    "time": "15:32",
    "type": 'وارده',
    "requiredAction": 'ارجاع',
    "idNumber": '112/سب/۴۴۵۶',
    "isAttachmentAvailable": false,
    "isChecked": true,
    "isSelected": false,
    "isOriginal": false,
    "isConfidential": false,
    "tagColor": Color(0xFF23CF91),
  },
];

String emailDemoText =
    "خواهشمند است در صورت موافقت و صلاحدید با تقاضای خرید اقلام هماهنگی لازم جهت تایید انجام گردد.\nقبلا از دستور مساعدت و محبتی که می فرمایید نهایت تشکر و قدر دانی را دارم.\nبا تقدیم احترام\nنام و نام خانوادگی\nامضاء";
