enum DocumentType {
  sundayLitrugy("قداس الاحد"),
  fridayLitrugy("قداس الجمعة"),
  eve("العشية"),
  classAttendance("الحصة");

  final String value;

  const DocumentType(this.value);

  String getValue() {
    return value;
  }
}


//
// if (sundayLitrugyCheckBox == true) {
// viewModel.setCollection(odasCheckBox: sundayLitrugyCheckBox, collectionId: widget.collectionReferenceId, documentId: widget.username, day: "قداس الاحد");
// }
// if (fridayLitrugyCheckBox == true) {
// viewModel.setCollection(odasCheckBox: fridayLitrugyCheckBox, collectionId: widget.collectionReferenceId, documentId: widget.username, day: "قداس الجمعة");
// }
// if (eveCheckBox == true) {
// viewModel.setCollection(odasCheckBox: eveCheckBox, collectionId: widget.collectionReferenceId, documentId: widget.username, day: "العشية");
// }
// if (classCheckbox == true) {
// viewModel.setCollection(odasCheckBox: classCheckbox, collectionId: widget.collectionReferenceId, documentId: widget.username, day: "الحصة");
// }