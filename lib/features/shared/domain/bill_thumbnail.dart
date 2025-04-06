class BillThumbnail {

  final String billId;
  final String billName;
  final String proposers;
  final String? legislativeBody;

  const BillThumbnail({
    required this.billId,
    required this.billName,
    required this.proposers,
    this.legislativeBody
  });
}
