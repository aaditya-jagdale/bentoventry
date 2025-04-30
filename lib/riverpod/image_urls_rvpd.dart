import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:textile/modules/shared/api/api_calls.dart';

class ImageUrlsNotifier extends StateNotifier<Map<int, String>> {
  ImageUrlsNotifier() : super({});

  Future<String> getImageUrl(int itemId, String imageName) async {
    // If we already have the URL cached, return it
    if (state.containsKey(itemId)) {
      return state[itemId]!;
    }

    // Otherwise fetch it and cache it
    final url = await ApiCalls.getImageUrl(imageName);
    state = {...state, itemId: url};
    return url;
  }
}

final imageUrlsProvider =
    StateNotifierProvider<ImageUrlsNotifier, Map<int, String>>((ref) {
      return ImageUrlsNotifier();
    });
