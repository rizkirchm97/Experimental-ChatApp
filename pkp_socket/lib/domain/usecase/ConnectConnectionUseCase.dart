
import 'package:pkp_socket/domain/repositories/pkprepositories.dart';

class ConnectConnectionUseCase {
  final PkpRepositories _pkpRepositories;

  ConnectConnectionUseCase(this._pkpRepositories);

  Future<void> invoke() async {
    await _pkpRepositories.connect();
  }

}