
import 'package:injectable/injectable.dart';
import 'package:rama_poke_app/core/shared/models/pokemon_model.dart';

@singleton
class StringToPokemonTypeMapper {
  TypeOfPokemon map(String type) {
    switch (type.toLowerCase()) {
      case 'bug':
        return TypeOfPokemon.bug;
      case 'dark':
        return TypeOfPokemon.dark;
      case 'dragon':
        return TypeOfPokemon.dragon;
      case 'electric':
        return TypeOfPokemon.electric;
      case 'fairy':
        return TypeOfPokemon.fairy;
      case 'fighting':
        return TypeOfPokemon.fighting;
      case 'fire':
        return TypeOfPokemon.fire;
      case 'flying':
        return TypeOfPokemon.flying;
      case 'ghost':
        return TypeOfPokemon.ghost;
      case 'grass':
        return TypeOfPokemon.grass;
      case 'ground':
        return TypeOfPokemon.ground;
      case 'ice':
        return TypeOfPokemon.ice;
      case 'normal':
        return TypeOfPokemon.normal;
      case 'poison':
        return TypeOfPokemon.poison;
      case 'psychic':
        return TypeOfPokemon.psychic;
      case 'rock':
        return TypeOfPokemon.rock;
      case 'steel':
        return TypeOfPokemon.steel;
      case 'water':
        return TypeOfPokemon.water;
      default:
        return TypeOfPokemon.normal; 
    }
  }
}
