import 'pokemon.dart';

// ═══════════════════════════════════════════════════════════════
// Funções auxiliares de exibição
// Responsáveis apenas por formatar e imprimir — sem lógica de negócio
// ═══════════════════════════════════════════════════════════════

// Exibe uma lista de pokémons com título
void exibirLista(String titulo, List<Pokemon> lista) {
  print('');
  print('=== $titulo ===');
  if (lista.isEmpty) {
    print('  (nenhum resultado)');
  } else {
    for (final p in lista) {
      print('  #${p.numero.toString().padLeft(3, '0')} ${p.nome} | Tipo: ${p.tipo} | Nível: ${p.nivel} | HP: ${p.hpAtual}/${p.hpMaximo}');
    }
  }
}

// Exibe as estatísticas da Pokédex formatadas
void exibirStats(int total, Map<String, int> porTipo, double media, double percentual) {
  print('');
  print('╔══════════════════════════════╗');
  print('║   ESTATÍSTICAS DA POKÉDEX   ║');
  print('╠══════════════════════════════╣');
  print('║ Total de pokémons: $total'.padRight(31) + '║');
  print('║ Média de nível: ${media.toStringAsFixed(1)}'.padRight(31) + '║');
  print('║ % capturados: ${percentual.toStringAsFixed(1)}%'.padRight(31) + '║');
  print('║ Por tipo:'.padRight(31) + '║');
  porTipo.forEach((tipo, qtd) {
    print('║   $tipo: $qtd'.padRight(31) + '║');
  });
  print('╚══════════════════════════════╝');
}

// Exibe um separador visual com título para organizar o output
void exibirSeparador(String titulo) {
  print('');
  print('══════════════════════════════════════');
  print(' $titulo');
  print('══════════════════════════════════════');
}
