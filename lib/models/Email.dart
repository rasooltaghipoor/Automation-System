import 'package:flutter/material.dart';

class Email {
  final String? image, name, subject, body, time;
  final bool? isAttachmentAvailable, isChecked;
  final Color? tagColor;

  Email({
    this.time,
    this.isChecked,
    this.image,
    this.name,
    this.subject,
    this.body,
    this.isAttachmentAvailable,
    this.tagColor,
  });
}

List<Email> emails = List.generate(
  demo_data.length,
  (index) => Email(
    name: demo_data[index]['name'],
    image: demo_data[index]['image'],
    subject: demo_data[index]['subject'],
    isAttachmentAvailable: demo_data[index]['isAttachmentAvailable'],
    isChecked: demo_data[index]['isChecked'],
    tagColor: demo_data[index]['tagColor'],
    time: demo_data[index]['time'],
    body: emailDemoText,
  ),
);

List demo_data = [
  {
    "name": "مدیر فنی",
    "image": "assets/images/user_1.png",
    "subject": "تقاضای تجهیزات",
    "isAttachmentAvailable": false,
    "isChecked": true,
    "tagColor": null,
    "time": "Now"
  },
  {
    "name": "ریاست",
    "image": "assets/images/user_2.png",
    "subject": "تجهیز کارگاه کامپیوتر",
    "isAttachmentAvailable": true,
    "isChecked": false,
    "tagColor": null,
    "time": "15:32"
  },
  {
    "name": "محمد لکزیان",
    "image": "assets/images/user_3.png",
    "subject": "درخواست وام بدون بهره",
    "isAttachmentAvailable": true,
    "isChecked": false,
    "tagColor": null,
    "time": "14:27",
  },
  {
    "name": "علی علی زاده",
    "image": "assets/images/user_4.png",
    "subject": "فراغت از تحصیل",
    "isAttachmentAvailable": false,
    "isChecked": true,
    "tagColor": Color(0xFF23CF91),
    "time": "10:43"
  },
  {
    "name": "کامران لطفی",
    "image": "assets/images/user_5.png",
    "subject": "موافقت با مرخصی",
    "isAttachmentAvailable": false,
    "isChecked": false,
    "tagColor": Color(0xFF3A6FF7),
    "time": "9:58"
  }
];

String emailDemoText =
    "خواهشمند است در صورت موافقت و صلاحدید با تقاضای خرید اقلام هماهنگی لازم جهت تایید انجام گردد.\nقبلا از دستور مساعدت و محبتی که می فرمایید نهایت تشکر و قدر دانی را دارم.\nبا تقدیم احترام\nنام و نام خانوادگی\nامضاء";
