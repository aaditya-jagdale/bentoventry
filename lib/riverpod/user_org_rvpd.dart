import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:textile/home/models/user_org_model.dart';

final userOrgProvider = StateNotifierProvider<UserOrgNotifier, UserOrgModel?>((
  ref,
) {
  return UserOrgNotifier();
});

class UserOrgNotifier extends StateNotifier<UserOrgModel?> {
  UserOrgNotifier() : super(null);

  void setUserOrg(UserOrgModel userOrg) {
    state = userOrg;
  }

  void clearUserOrg() {
    state = null;
  }
}
