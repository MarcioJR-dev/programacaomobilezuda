import '../classes/pokemon.dart';
import '../classes/pokedex.dart';
import '../classes/habilidades.dart';
import '../classes/exibicao.dart';

void main() {
  // ══════════════════════════════════════════════════════════════
  // QUESTÃO 1 — Cadastro básico e exibirFicha()
  // Instancia 3 pokémons e exibe a ficha de cada um
  // ══════════════════════════════════════════════════════════════
  exibirSeparador('Q1 - Cadastro básico de Pokémon');

  final bulbasaur = Pokemon(
    numero: 1,
    nome: 'Bulbasaur',
    tipo: 'Planta',
    nivel: 10,
    hpAtual: 45,
    hpMaximo: 45,
    proximaEvolucao: 'Ivysaur',
    nivelEvolucao: 16,
  );

  final psyduck = Pokemon(
    numero: 54,
    nome: 'Psyduck',
    tipo: 'Água',
    nivel: 15,
    hpAtual: 50,
    hpMaximo: 50,
  );

  final snorlax = Pokemon(
    numero: 143,
    nome: 'Snorlax',
    tipo: 'Normal',
    nivel: 40,
    hpAtual: 160,
    hpMaximo: 160,
  );

  bulbasaur.exibirFicha();
  psyduck.exibirFicha();
  snorlax.exibirFicha();

  // ══════════════════════════════════════════════════════════════
  // QUESTÃO 2 — Encapsulamento e validação de regras
  // Demonstra subirNivel, receberDano, curar com valores válidos e inválidos
  // ══════════════════════════════════════════════════════════════
  exibirSeparador('Q2 - Encapsulamento e validação');

  print('HP antes do dano: ${bulbasaur.hpAtual}');
  bulbasaur.receberDano(100);   // tenta tirar mais HP do que tem
  print('HP após dano de 100 (não pode ficar negativo): ${bulbasaur.hpAtual}');

  bulbasaur.curar(200);          // tenta curar além do máximo
  print('HP após cura de 200 (não pode passar do máximo): ${bulbasaur.hpAtual}');

  bulbasaur.subirNivel(95);     // tenta passar de nível 100
  print('Nível após subir 95 (máximo é 100): ${bulbasaur.nivel}');

  bulbasaur.receberDano(-5);    // valor negativo é ignorado
  print('receberDano(-5) ignorado. HP: ${bulbasaur.hpAtual}');

  snorlax.subirNivel(5);
  print('Snorlax subiu 5 níveis. Nível atual: ${snorlax.nivel}');
  snorlax.receberDano(30);
  print('Snorlax recebeu 30 de dano. HP: ${snorlax.hpAtual}');

  // ══════════════════════════════════════════════════════════════
  // QUESTÃO 3 — Evolução com regra fixa
  // ══════════════════════════════════════════════════════════════
  exibirSeparador('Q3 - Evolução com regra fixa');

  final charmander = Pokemon(
    numero: 4,
    nome: 'Charmander',
    tipo: 'Fogo',
    nivel: 10,
    hpAtual: 39,
    hpMaximo: 39,
    proximaEvolucao: 'Charmeleon',
    nivelEvolucao: 16,
  );

  print('Tentando evoluir com nível insuficiente:');
  charmander.evoluir();          // nível 10 < 16, falha

  charmander.subirNivel(10);     // sobe para nível 20
  print('Nível subiu para ${charmander.nivel}, agora tenta evoluir:');
  charmander.evoluir();          // sucesso

  print('Nome agora: ${charmander.nome} | HP Máximo: ${charmander.hpMaximo}');
  charmander.evoluir();          // proximaEvolucao é null, não pode mais

  // ══════════════════════════════════════════════════════════════
  // QUESTÃO 4 — Criação da Pokédex
  // ══════════════════════════════════════════════════════════════
  exibirSeparador('Q4 - Criação da Pokédex');

  final pokedex = Pokedex();

  // Criando os pokémons (Q12 exige 8+ de 3+ tipos)
  final pikachu = PokemonEletrico(
    numero: 25, nome: 'Pikachu', nivel: 30,
    hpAtual: 60, hpMaximo: 60, energia: 100,
    proximaEvolucao: 'Raichu', nivelEvolucao: 35,
  );
  final squirtle = PokemonAgua(
    numero: 7, nome: 'Squirtle', nivel: 12,
    hpAtual: 44, hpMaximo: 44, energia: 100,
    proximaEvolucao: 'Wartortle', nivelEvolucao: 16,
  );
  final charmander2 = PokemonFogo(
    numero: 4, nome: 'Charmander', nivel: 10,
    hpAtual: 39, hpMaximo: 39, energia: 100,
    proximaEvolucao: 'Charmeleon', nivelEvolucao: 16,
  );
  final geodude = Pokemon(
    numero: 74, nome: 'Geodude', tipo: 'Pedra',
    nivel: 20, hpAtual: 40, hpMaximo: 40,
  );
  final jigglypuff = Pokemon(
    numero: 39, nome: 'Jigglypuff', tipo: 'Normal',
    nivel: 15, hpAtual: 25, hpMaximo: 70,
  );
  final mewtwo = Pokemon(
    numero: 150, nome: 'Mewtwo', tipo: 'Psíquico',
    nivel: 70, hpAtual: 106, hpMaximo: 106, energia: 150,
  );
  final eevee = Pokemon(
    numero: 133, nome: 'Eevee', tipo: 'Normal',
    nivel: 18, hpAtual: 55, hpMaximo: 55,
    proximaEvolucao: 'Vaporeon', nivelEvolucao: 20,
  );
  final magikarp = PokemonAgua(
    numero: 129, nome: 'Magikarp', nivel: 5,
    hpAtual: 20, hpMaximo: 20, energia: 100,
    proximaEvolucao: 'Gyarados', nivelEvolucao: 20,
  );

  // Adiciona os 9 pokémons
  pokedex.adicionarPokemon(bulbasaur);
  pokedex.adicionarPokemon(pikachu);
  pokedex.adicionarPokemon(squirtle);
  pokedex.adicionarPokemon(charmander2);
  pokedex.adicionarPokemon(geodude);
  pokedex.adicionarPokemon(jigglypuff);
  pokedex.adicionarPokemon(mewtwo);
  pokedex.adicionarPokemon(eevee);
  pokedex.adicionarPokemon(magikarp);

  // Testa duplicata (mesmo número 1)
  pokedex.adicionarPokemon(Pokemon(
    numero: 1, nome: 'Bulbasaur Duplicado', tipo: 'Planta',
    nivel: 5, hpAtual: 10, hpMaximo: 10,
  ));

  // Testa busca e remoção
  print('\nBusca por número 25 (Pikachu):');
  final encontrado = pokedex.buscarPorNumero(25);
  print('Encontrado: ${encontrado?.nome ?? 'null'}');

  print('\nBusca por número 999 (inexistente):');
  print('Encontrado: ${pokedex.buscarPorNumero(999)?.nome ?? 'null'}');

  pokedex.removerPokemonPorNumero(54);   // remove Psyduck (não está na pokédex)
  pokedex.removerPokemonPorNumero(74);   // remove Geodude, depois re-adiciona
  pokedex.adicionarPokemon(geodude);

  exibirLista('Todos os pokémons da Pokédex', pokedex.listarTodos().toList());

  // ══════════════════════════════════════════════════════════════
  // QUESTÃO 5 — Filtros obrigatórios
  // ══════════════════════════════════════════════════════════════
  exibirSeparador('Q5 - Filtros obrigatórios');

  // Marca alguns antes de filtrar
  pikachu.marcarComoCapturado();
  squirtle.marcarComoCapturado();
  mewtwo.marcarComoCapturado();
  geodude.marcarComoVisto();

  exibirLista('Pokémons Capturados', pokedex.listarCapturados());
  exibirLista('Pokémons do tipo "Água"', pokedex.listarPorTipo('Água'));
  exibirLista('Pokémons acima do nível 20', pokedex.listarAcimaDoNivel(20));
  exibirLista('Pokémons que podem evoluir', pokedex.listarQuePodemEvoluir());

  // ══════════════════════════════════════════════════════════════
  // QUESTÃO 6 — Herança por tipo de Pokémon
  // ══════════════════════════════════════════════════════════════
  exibirSeparador('Q6 - Herança e sobrescrita de calcularAtaqueBase()');

  print('PokemonFogo     (nível ${charmander2.nivel}): ataque = ${charmander2.calcularAtaqueBase()} (nivel * 3)');
  print('PokemonAgua     (nível ${squirtle.nivel}): ataque = ${squirtle.calcularAtaqueBase()} (nivel * 2 + 10)');
  print('PokemonEletrico (nível ${pikachu.nivel}): ataque = ${pikachu.calcularAtaqueBase()} (nivel * 2 + 15)');

  print('\nFicha com categoria (@override em exibirFicha):');
  charmander2.exibirFicha();

  // ══════════════════════════════════════════════════════════════
  // QUESTÃO 7 — Habilidades com classe abstrata
  // ══════════════════════════════════════════════════════════════
  exibirSeparador('Q7 - Habilidades com classe abstrata');

  final choque = ChoqueDoTrovao();
  final jato = JatoDAgua();
  final chamas = LancaChamas();

  print('Habilidades criadas: ${choque.nome} (custo ${choque.custoEnergia}), '
      '${jato.nome} (custo ${jato.custoEnergia}), '
      '${chamas.nome} (custo ${chamas.custoEnergia})');

  // ══════════════════════════════════════════════════════════════
  // QUESTÃO 8 — Polimorfismo em batalha
  // executarBatalha() não sabe qual habilidade é — só chama usar()
  // ══════════════════════════════════════════════════════════════
  exibirSeparador('Q8 - Polimorfismo em batalha');

  squirtle.curar(100);
  mewtwo.curar(200);

  // Turno 1: Pikachu usa Choque do Trovão em Squirtle
  executarBatalha(pikachu, squirtle, choque);

  // Turno 2: Squirtle usa Jato d'Água em Charmander
  squirtle.curar(100);
  executarBatalha(squirtle, charmander2, jato);

  // Turno 3: continua se Charmander ainda está de pé
  if (charmander2.hpAtual > 0) {
    executarBatalha(squirtle, charmander2, jato);
  }

  // ══════════════════════════════════════════════════════════════
  // QUESTÃO 9 — Interface de registro
  // ══════════════════════════════════════════════════════════════
  exibirSeparador('Q9 - Interface de registro');

  eevee.marcarComoVisto();
  eevee.marcarComoCapturado();
  eevee.favoritar();

  jigglypuff.favoritar();   // falha: não foi capturado

  // ══════════════════════════════════════════════════════════════
  // QUESTÃO 10 — Funções anônimas para consultas
  // As funções anônimas são os lambdas dentro de where() e sort()
  // Ex: (p) => p.hpAtual < 30   ← isso é uma função anônima
  // ══════════════════════════════════════════════════════════════
  exibirSeparador('Q10 - Funções anônimas');

  // Força HP baixo em alguns para aparecer no filtro
  jigglypuff.receberDano(50);
  magikarp.receberDano(10);

  final todos = pokedex.listarTodos().toList();

  // Filtro anônimo: pokémons com HP abaixo de 30
  final comHpBaixo = todos.where((p) => p.hpAtual < 30).toList();
  exibirLista('Pokémons com HP abaixo de 30', comHpBaixo);

  // Ordenação anônima: alfabética por nome
  final porNome = List<Pokemon>.from(todos)
    ..sort((a, b) => a.nome.compareTo(b.nome));
  exibirLista('Pokémons ordenados por nome (A-Z)', porNome);

  // Ordenação anônima: nível decrescente
  final porNivel = List<Pokemon>.from(todos)
    ..sort((a, b) => b.nivel.compareTo(a.nivel));
  exibirLista('Pokémons ordenados por nível (maior primeiro)', porNivel);

  // Seleção anônima: apenas favoritos
  final favoritos = todos.where((p) => p.favorito).toList();
  exibirLista('Pokémons favoritos', favoritos);

  // ══════════════════════════════════════════════════════════════
  // QUESTÃO 11 — Estatísticas da Pokédex
  // ══════════════════════════════════════════════════════════════
  exibirSeparador('Q11 - Estatísticas da Pokédex');

  exibirStats(
    pokedex.totalPokemons(),
    pokedex.quantidadePorTipo(),
    pokedex.mediaDeNivel(),
    pokedex.percentualCapturados(),
  );

  // ══════════════════════════════════════════════════════════════
  // QUESTÃO 12 — Simulação completa do app
  // ══════════════════════════════════════════════════════════════
  exibirSeparador('Q12 - Simulação completa do app');

  // Favoritar 2+ pokémons
  pikachu.favoritar();
  mewtwo.favoritar();

  // Realizar pelo menos 1 evolução
  squirtle.subirNivel(10);   // sobe para nível 22 >= 16
  squirtle.evoluir();        // Squirtle → Wartortle

  // Simular mais batalhas (total de 2+)
  pikachu.curar(200);
  geodude.curar(200);
  executarBatalha(pikachu, geodude, choque);

  // Aplicar todos os filtros da Q5
  print('\n-- Filtros finais --');
  exibirLista('Capturados', pokedex.listarCapturados());
  exibirLista('Tipo Fogo', pokedex.listarPorTipo('Fogo'));
  exibirLista('Acima do nível 15', pokedex.listarAcimaDoNivel(15));
  exibirLista('Podem evoluir', pokedex.listarQuePodemEvoluir());

  // Estatísticas finais
  exibirSeparador('Estatísticas Finais');
  exibirStats(
    pokedex.totalPokemons(),
    pokedex.quantidadePorTipo(),
    pokedex.mediaDeNivel(),
    pokedex.percentualCapturados(),
  );
}
