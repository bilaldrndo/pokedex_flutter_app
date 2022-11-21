import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex_app/models/api_status.dart';
import 'package:pokedex_app/services/api_requests.dart';

void main() {
  test('Testing The All Pokemons Endpoint', () async {
    bool isOk = false;
    var response = await APIRequests().getInitialAndPaginatePokemons();

    if (response is Success) {
      isOk = true;
    } else {
      isOk = false;
    }
    expect(isOk, true);
  });

  test('Testing The Single Pokemon Endpoint', () async {
    bool isOk = false;
    var response = await APIRequests().getDataAboutSpecificPokemon('${APIRequests().basicEndpoint}/2/');

    if (response is Success) {
      isOk = true;
    } else {
      isOk = false;
    }
    expect(isOk, true);
  });
}
