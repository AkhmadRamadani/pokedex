import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:rama_poke_app/core/databases/constants/hive_constant.dart';
import 'package:rama_poke_app/core/databases/hive_model/favorite_hive_model.dart';
import 'package:rama_poke_app/core/databases/hive_model/pokemon_hive_model.dart';

class FavoriteLocalService {
  Box<FavoriteHiveModel> get _favoriteBox =>
      Hive.box<FavoriteHiveModel>(HiveConstant.favoriteBoxKey);
  Box<PokemonHiveModel> get _pokemonBox =>
      Hive.box<PokemonHiveModel>(HiveConstant.pokemonBoxKey);

  Future<void> addToFavorites(String id) async {
    if (await isFavorite(id)) return;
    await _favoriteBox.put(
      id,
      FavoriteHiveModel(
        entityId: id,
        addedAt: DateTime.now(),
        order: _favoriteBox.length,
      ),
    );
  }

  Future<void> removeFromFavorites(String id) => _favoriteBox.delete(id);

  Future<bool> toggleFavorite(String id) async {
    final isFav = await isFavorite(id);
    isFav ? await removeFromFavorites(id) : await addToFavorites(id);
    return !isFav;
  }

  Future<bool> isFavorite(String id) async => _favoriteBox.containsKey(id);

  Future<List<String>> getFavoriteIds() async =>
      _favoriteBox.values.map((e) => e.entityId).toList();

  Future<List<PokemonHiveModel>> getFavoritePokemons() async {
    return getFavoriteIds().then(
      (ids) =>
          ids
              .map((id) => _pokemonBox.get(id))
              .whereType<PokemonHiveModel>()
              .toList(),
    );
  }

  Future<List<PokemonHiveModel>> getFavoritesSortedByDate({
    bool ascending = false,
  }) async {
    final sorted =
        _favoriteBox.values.toList()..sort(
          (a, b) =>
              ascending
                  ? a.addedAt.compareTo(b.addedAt)
                  : b.addedAt.compareTo(a.addedAt),
        );
    return sorted
        .map((f) => _pokemonBox.get(f.entityId))
        .whereType<PokemonHiveModel>()
        .toList();
  }

  Future<int> getFavoritesCount() async => _favoriteBox.length;

  Future<void> clearAllFavorites() async => _favoriteBox.clear();

  Future<Map<String, bool>> getFavoriteStatusMap(List<String> ids) async {
    return {for (final id in ids) id: _favoriteBox.containsKey(id)};
  }
}
