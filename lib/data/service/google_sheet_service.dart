import 'package:gsheets/gsheets.dart';

class GoogleSheetService {
  static const String _credentials = r'''
   {
  "type": "service_account",
  "project_id": "shamamsa-db",
  "private_key_id": "a309751bddcc1596fcadc609b33c14090040075a",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC0wcJxS5V3qWoL\nLeI6MPXhnhrImVp9BuWdfEzk/ub/OBovFnwDOhexZfnyNNxWTG4MG9v80ABMK1ev\nhRfRitg7BGXhHfe7+xWnWSqDq1ennpvruM6ksY5W/e/39AN/VRbtvgGy+EkWkzml\naU1jIzW9iK1tz25ckf5eoM8ZXiO32yB2lLc3I8WFxMQA1F4c9cKArhW1jmotMorF\nUSJWflctF//uG491F49vD65tpHW1FcGpWZZb00BDeV6fubMyUrE1zOqAKC1pNCDi\n+URoKMWwS8RZDVMWx2FRRvEX7IspoprObYcL4ZZtYEJ3I8MhcONXlmJesysWQnET\njTiPBmjNAgMBAAECggEAONniMqkPqzG1ISv+xcelZh9IlEQrYjx7lpNEShfkBmya\nS6oaOheY4RpOSUAX9uqWCCfxAmxXU52kOBe3vJebV8CT3ICE7PJVRqu0Q/JtoNIx\nfyvCjqkruC+pPIbaXL+h9Qd4WFZgAoIutNhQVzh5TBIDXhDKSMJAS3nveS6TNF1n\nQOqqdWV5vG6rmW4GPQCLh7c+s9OgskdLHXAu8ni6OXdteHHuvXYyjb0dVuVzw66L\ndvPJpf+RLWoa8JfAREu0DoCCcGxl0TeLKr2D71k4KlTqtz08rMB1rVOlKC7lCmSp\nBCB8IJV0wjngLSJgu5m9uHiEO63sAlftCKc3gRc4rwKBgQDgmB5zGcs0PfxRwgKL\n70n1R6JcaA1pQMLMbNN7r9iy9xyhr6D7KNjAejggm+KO/hjRM9jzWCUjK5ZVvOVr\n1its3pknAxK2sbbKPyyns/RtZ2c+wwxtwSd5BDTUIytqmVeSZkZepp0Keijz8IbB\nZVTrvPe/Occ8VShe8DCBWmK6twKBgQDOCGEZLETcsZMg2htuIBlfpBsgDko+vljp\nTWcPoeAva5h70rI0YEERkFPkbxE5ORrYD4WI+q+FZmNQF3YYmXNwQQOAaTIgE2vr\n279dSODPZQ2eKzBbzKci9JuZTCnKf4SS/n++dhn/uUhtri5/lu5tM/flDx+KRqt0\n73nZpc+EmwKBgQDgXxgMZPhceJBaHTfuFGAOakIJjunW/JufHhkot8QFBlnULWDl\niSkBIRhxe0obED46wVE7yhNPz3ugq9WGpa88VCUslCVd3qx94B78awsFQQgj6ze/\nbffBLjKYu4nkNM0HtKUYadr5XJENIn19N35fA6l9oHsqCukJ72qFz4ZSgQKBgEhQ\n4pvuUOFRpr2iMHyP4bgTJr4ypdauAxEobOMswz6BuozDoG8H1e7vRLLqVRZLt+Nc\nV1eD/fWJwZQMGBR8T+t3tl3tDn35syifAeUhPl8tLgF1UUz3YTbAupitBgIgjgz2\nLSpR08BRbV2qBIIeHOPRmNIaY8yqD2ZE4/UD4Pm/AoGARyHqYjKPDfMnHquReXjk\no1v0V2SqIgjTbXECKz1dklCbXiJcHNLIkGs3k0uZSVs4q0QKYciTUHiB51DVUCrj\nisMMsQpLuhXwWd3WzthfmOpgy5oLtevAFSsJfjRS3URQoXiUjRb2yutLgcqV15e6\nZqzrZLtbRm1l4I3lWbkzckw=\n-----END PRIVATE KEY-----\n",
  "client_email": "shamamsa-db@shamamsa-db.iam.gserviceaccount.com",
  "client_id": "114291481056124369457",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/shamamsa-db%40shamamsa-db.iam.gserviceaccount.com"
}
   ''';

  static const _spreadsheetId = "1hwOEj6QQFqjg99OmrPI6MYste85_0klB8sZYn0k8avY";
  static final _gSheet = GSheets(_credentials);
  static Worksheet? _workSheet;

  static Future init() async {
    final spreadsheet = await _gSheet.spreadsheet(_spreadsheetId);
    _workSheet = await _getWorkSheet(spreadsheet, title: "User");
  }

  static Future<Worksheet> _getWorkSheet(Spreadsheet spreadsheet,
      {required String title}) async {
    try {
      return await spreadsheet.addWorksheet(title);
    } catch (e) {

      return spreadsheet.worksheetByTitle(title)!;

    }
  }
}
