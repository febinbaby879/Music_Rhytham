
import '../../core/contatants/const.dart';

class CheckPermission {
  //Permissin check cheyan vendi olla class Adym init state il vilikandeath ith anne
  //Becouse _hasPermission varieble nte result nokeet enam List lekk Song add cheyan

  static Future<bool> checkAndRequestPermissions({bool retry = false}) async {
    bool _hasPermission = false;
    _hasPermission = await audioQuery.checkAndRequest(
      retryRequest: retry,
    );
    return _hasPermission;
  }
}