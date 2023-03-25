import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../enums/document_type.dart';
import '../resources/color_manager.dart';
import '../resources/style_manager.dart';
import 'custom_text.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet(
      {Key? key,
      required this.egtmaaStream,
      required this.tasbehaStream,
      required this.odasStream})
      : super(key: key);

  final Stream<List<QueryDocumentSnapshot>> egtmaaStream;
  final Stream<List<QueryDocumentSnapshot>> tasbehaStream;
  final Stream<List<QueryDocumentSnapshot>> odasStream;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          StreamBuilder<List<QueryDocumentSnapshot>>(
              stream: egtmaaStream,
              builder: (context, snapshot) {
                if (snapshot.data != null) {
                  return ListTile(
                    leading: Icon(
                      Icons.add_circle,
                      color: ColorsManager.white,
                    ),
                    title: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: CustomText(
                        text: DocumentType.EGTMAA.value,
                        style: StyleManager.cairoMediumBold
                            .getStyle(context: context)
                            .copyWith(color: ColorsManager.white),
                      ),
                    ),
                    trailing: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: CustomText(
                        text:
                            "عدد مرات الحضور   ${snapshot.data!.length.toString()}",
                        style: StyleManager.cairoMediumBold
                            .getStyle(context: context)
                            .copyWith(color: ColorsManager.white),
                      ),
                    ),
                  );
                }
                return Container();
              }),
          StreamBuilder<List<QueryDocumentSnapshot>>(
              stream: tasbehaStream,
              builder: (context, snapshot) {
                if (snapshot.data != null) {
                  return ListTile(
                    leading: Icon(
                      Icons.add_circle,
                      color: ColorsManager.white,
                    ),
                    title: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: CustomText(
                        text: DocumentType.TASBEHA.value,
                        style: StyleManager.cairoMediumBold
                            .getStyle(context: context)
                            .copyWith(color: ColorsManager.white),
                      ),
                    ),
                    trailing: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: CustomText(
                        text:
                            "عدد مرات الحضور   ${snapshot.data!.length.toString()}",
                        style: StyleManager.cairoMediumBold
                            .getStyle(context: context)
                            .copyWith(color: ColorsManager.white),
                      ),
                    ),
                  );
                }
                return Container();
              }),
          StreamBuilder<List<QueryDocumentSnapshot>>(
              stream: odasStream,
              builder: (context, snapshot) {
                if (snapshot.data != null) {
                  return ListTile(
                    leading: Icon(
                      Icons.add_circle,
                      color: ColorsManager.white,
                    ),
                    title: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: CustomText(
                        text: DocumentType.ODAS.value,
                        style: StyleManager.cairoMediumBold
                            .getStyle(context: context)
                            .copyWith(color: ColorsManager.white),
                      ),
                    ),
                    trailing: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: CustomText(
                        text:
                            "عدد مرات الحضور   ${snapshot.data!.length.toString()}",
                        style: StyleManager.cairoMediumBold
                            .getStyle(context: context)
                            .copyWith(color: ColorsManager.white),
                      ),
                    ),
                  );
                }
                return Container();
              }),
        ],
      ),
    );
  }
}
