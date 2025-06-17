abstract interface class ReadStatusRepository {

  Future<void> markAsRead(String billId);

  Future<bool> isRead(String billId);
}