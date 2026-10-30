import 'package:supabase_flutter/supabase_flutter.dart';

abstract class ContactRemoteDataSource {
  Future<void> submitMessage({
    required String name,
    required String email,
    required String phone,
    required String message,
  });
}

/// Used when the build has no Supabase URL/key; the form reports a failure.
class ContactRemoteDataSourceUnavailable implements ContactRemoteDataSource {
  const ContactRemoteDataSourceUnavailable();

  @override
  Future<void> submitMessage({
    required String name,
    required String email,
    required String phone,
    required String message,
  }) =>
      Future.error(StateError('Supabase is not configured'));
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
