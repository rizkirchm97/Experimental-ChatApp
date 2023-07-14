

import '../repositories/pkprepositories.dart';

class DisconnectConnectionUseCase {

  final PkpRepositories _pkpRepositories;

  DisconnectConnectionUseCase(this._pkpRepositories);

  Future<void> invoke() async {
    await _pkpRepositories.disconnect();
  }
}