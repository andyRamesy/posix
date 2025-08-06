class SendInvitRequestParams {
  final String receiverPhon;

  SendInvitRequestParams({required this.receiverPhon});

  Map<String, dynamic> toMap() {
    return {
      'receiverPhon': receiverPhon,
    };
  }
}
