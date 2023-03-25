enum DocumentType {
  ODAS("قداس"),
  TASBEHA("تسبحة"),
  EGTMAA("اجتماع");

  final String value;

  const DocumentType(this.value);

  String getValue() {
    return value;
  }
}
