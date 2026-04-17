import 'pokemon.dart';

// ═══════════════════════════════════════════════════════════════
// QUESTÃO 7 — Classe abstrata Habilidade
//
// Uma classe abstrata não pode ser instanciada diretamente.
// Ela serve como "molde" para as classes concretas.
// O método abstrato usar() OBRIGA cada subclasse a implementá-lo.
// ═══════════════════════════════════════════════════════════════
abstract class Habilidade {
  final String nome;
  final int custoEnergia;

  Habilidade({required this.nome, required this.custoEnergia});

  // Método abstrato: não tem corpo aqui, cada subclasse define o seu
  void usar(Pokemon usuario, Pokemon alvo);
}

// ═══════════════════════════════════════════════════════════════
// QUESTÃO 7 — Implementações concretas das habilidades
//
// Cada classe herda Habilidade e implementa usar() com seu dano.
// ChoqueDoTrovao: dano = ataqueBase + 5
// JatoDAgua:     dano = ataqueBase + 3
// LancaChamas:   dano = ataqueBase + 7
// ═══════════════════════════════════════════════════════════════

class ChoqueDoTrovao extends Habilidade {
  ChoqueDoTrovao() : super(nome: 'Choque do Trovão', custoEnergia: 20);

  @override
  void usar(Pokemon usuario, Pokemon alvo) {
    if (usuario.energia < custoEnergia) {
      print('[${usuario.nome}] Energia insuficiente (tem ${usuario.energia}, precisa $custoEnergia).');
      return;
    }
    usuario.energia -= custoEnergia;
    final dano = usuario.calcularAtaqueBase() + 5;
    alvo.receberDano(dano);
    print('[${usuario.nome}] usou $nome causando $dano de dano! HP de ${alvo.nome}: ${alvo.hpAtual}/${alvo.hpMaximo}');
  }
}

class JatoDAgua extends Habilidade {
  JatoDAgua() : super(nome: "Jato d'Água", custoEnergia: 15);

  @override
  void usar(Pokemon usuario, Pokemon alvo) {
    if (usuario.energia < custoEnergia) {
      print('[${usuario.nome}] Energia insuficiente (tem ${usuario.energia}, precisa $custoEnergia).');
      return;
    }
    usuario.energia -= custoEnergia;
    final dano = usuario.calcularAtaqueBase() + 3;
    alvo.receberDano(dano);
    print('[${usuario.nome}] usou $nome causando $dano de dano! HP de ${alvo.nome}: ${alvo.hpAtual}/${alvo.hpMaximo}');
  }
}

class LancaChamas extends Habilidade {
  LancaChamas() : super(nome: 'Lança-Chamas', custoEnergia: 25);

  @override
  void usar(Pokemon usuario, Pokemon alvo) {
    if (usuario.energia < custoEnergia) {
      print('[${usuario.nome}] Energia insuficiente (tem ${usuario.energia}, precisa $custoEnergia).');
      return;
    }
    usuario.energia -= custoEnergia;
    final dano = usuario.calcularAtaqueBase() + 7;
    alvo.receberDano(dano);
    print('[${usuario.nome}] usou $nome causando $dano de dano! HP de ${alvo.nome}: ${alvo.hpAtual}/${alvo.hpMaximo}');
  }
}

// ═══════════════════════════════════════════════════════════════
// QUESTÃO 8 — Polimorfismo em batalha
//
// Esta função recebe qualquer Habilidade (ChoqueDoTrovao, JatoDAgua
// ou LancaChamas) e chama habilidade.usar() SEM saber qual é.
// O Dart descobre sozinho qual implementação chamar em tempo de execução.
// Isso é POLIMORFISMO: mesmo código, comportamento diferente por objeto.
// Não usa if/switch para descobrir o tipo — é desnecessário.
// ═══════════════════════════════════════════════════════════════
void executarBatalha(Pokemon atacante, Pokemon defensor, Habilidade habilidade) {
  print('');
  print('⚔  BATALHA: ${atacante.nome} vs ${defensor.nome}');
  print('── Turno ──────────────────────────────');

  // Polimorfismo: chama usar() sem saber qual habilidade é
  habilidade.usar(atacante, defensor);

  if (defensor.hpAtual <= 0) {
    print('${defensor.nome} foi derrotado!');
  }
  print('───────────────────────────────────────');
}
