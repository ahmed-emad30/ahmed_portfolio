import 'package:supabase_flutter/supabase_flutter.dart';

abstract class ContactRemoteDataSource {
  Future<void> submitMessage({
    required String name,
    required String email,
    required String phone,
    required String message,
  });
}

class ContactRemoteDataSourceImp implements ContactRemoteDataSource {
  ContactRemoteDataSourceImp(this._client);

  final SupabaseClient _client;

  @override
  Future<void> submitMessage({
    required String name,
    required String email,
    required String phone,
    required String message,
  }) async {
    await _client.from('contact_messages').insert({
      'name': name,
      'email': email,
      'phone': phone,
      'message': message,
    });
  }
}
