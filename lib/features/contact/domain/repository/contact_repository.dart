abstract class ContactRepository {
  Future<void> submitMessage({
    required String name,
    required String email,
    required String phone,
    required String message,
  });
}
