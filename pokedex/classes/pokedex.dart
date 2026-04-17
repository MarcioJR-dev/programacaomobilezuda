import 'pokemon.dart';

// ═══════════════════════════════════════════════════════════════
// QUESTÕES 4, 5, 11 — Classe Pokedex
//
// Q4: coleção interna + adicionar, remover, buscar, listarTodos
// Q5: filtros — listarCapturados, listarPorTipo, listarAcimaDoNivel,
//               listarQuePodemEvoluir
// Q11: estatísticas — totalPokemons, quantidadePorTipo,
//                     mediaDeNivel, percentualCapturados
// ═══════════════════════════════════════════════════════════════
class Pokedex {
  // Q4 — Coleção interna privada: só a própria classe pode modificar
  final List<Pokemon> _pokemons = [];

  // Q4 — Adiciona pokémon, mas não permite número duplicado
  void adicionarPokemon(Pokemon p) {
    // any() percorre a lista e retorna true se algum elemento satisfaz a condição
    final jaExiste = _pokemons.any((pk) => pk.numero == p.numero);
    if (jaExiste) {
      print('[Pokédex] Já existe um pokémon com o número ${p.numero}.');
      return;
    }
    _pokemons.add(p);
    print('[Pokédex] ${p.nome} adicionado!');
  }

  // Q4 — Remove por número e retorna true/false indicando se removeu
  bool removerPokemonPorNumero(int numero) {
    final tamanhoAntes = _pokemons.length;
    _pokemons.removeWhere((p) => p.numero == numero);
    final removido = _pokemons.length < tamanhoAntes;
    if (removido) {
      print('[Pokédex] Pokémon #$numero removido.');
    } else {
      print('[Pokédex] Pokémon #$numero não encontrado.');
    }
    return removido;
  }

  // Q4 — Busca por número: retorna o objeto Pokemon ou null se não encontrar
  // Pokemon? significa que pode retornar null (tipo nullable)
  Pokemon? buscarPorNumero(int numero) {
    try {
      return _pokemons.firstWhere((p) => p.numero == numero);
    } catch (_) {
      return null;
    }
  }

  // Q4 — Retorna lista não-modificável (proteção: ninguém altera de fora)
  List<Pokemon> listarTodos() => List.unmodifiable(_pokemons);

  // ─── FILTROS (Q5) ──────────────────────────────────────────────
  // where() percorre a lista e retorna apenas os elementos que satisfazem
  // a condição. É como um filtro. toList() converte o resultado em List.

  // Q5 — Apenas pokémons capturados
  List<Pokemon> listarCapturados() =>
      _pokemons.where((p) => p.capturado).toList();

  // Q5 — Por tipo (toLowerCase garante que 'fogo', 'Fogo', 'FOGO' funcionem)
  List<Pokemon> listarPorTipo(String tipo) =>
      _pokemons.where((p) => p.tipo.toLowerCase() == tipo.toLowerCase()).toList();

  // Q5 — Acima de um nível mínimo
  List<Pokemon> listarAcimaDoNivel(int nivelMinimo) =>
      _pokemons.where((p) => p.nivel > nivelMinimo).toList();

  // Q5 — Que podem evoluir: têm próxima evolução E já atingiram o nível
  List<Pokemon> listarQuePodemEvoluir() =>
      _pokemons
          .where((p) => p.proximaEvolucao != null && p.nivel >= p.nivelEvolucao)
          .toList();

  // ─── ESTATÍSTICAS (Q11) ────────────────────────────────────────

  // Q11 — Total simples
  int totalPokemons() => _pokemons.length;

  // Q11 — Agrupa por tipo em um Map<tipo, quantidade>
  // Map é como um dicionário: chave → valor
  Map<String, int> quantidadePorTipo() {
    final mapa = <String, int>{};
    for (final p in _pokemons) {
      // ?? 0 significa: se mapa[p.tipo] for null, usa 0
      mapa[p.tipo] = (mapa[p.tipo] ?? 0) + 1;
    }
    return mapa;
  }

  // Q11 — Média de nível como decimal (retorna 0 se vazia, sem erro)
  // fold() acumula um valor percorrendo a lista (como um somatório)
  double mediaDeNivel() {
    if (_pokemons.isEmpty) return 0;
    final soma = _pokemons.fold<int>(0, (acc, p) => acc + p.nivel);
    return soma / _pokemons.length;
  }

  // Q11 — Percentual entre 0 e 100 (retorna 0 se vazia, sem erro)
  double percentualCapturados() {
    if (_pokemons.isEmpty) return 0;
    final capturados = _pokemons.where((p) => p.capturado).length;
    return (capturados / _pokemons.length) * 100;
  }
}
