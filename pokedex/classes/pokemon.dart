// ═══════════════════════════════════════════════════════════════
// QUESTÃO 9 — Interface RegistravelNaPokedex
// Define o "contrato": qualquer classe que implemente essa interface
// OBRIGA a ter esses 4 métodos. É como uma promessa que a classe faz.
// ═══════════════════════════════════════════════════════════════
abstract class RegistravelNaPokedex {
  void marcarComoVisto();
  void marcarComoCapturado();
  void favoritar();
  void desfavoritar();
}

// ═══════════════════════════════════════════════════════════════
// QUESTÕES 1, 2, 3, 9 — Classe base Pokemon
//
// Q1: atributos obrigatórios + construtor + exibirFicha()
// Q2: atributos privados (_nivel, _hpAtual, _hpMaximo) com getters
//     e métodos com validação (subirNivel, receberDano, curar)
// Q3: lógica de evolução (proximaEvolucao, nivelEvolucao, evoluir())
// Q9: implementa a interface RegistravelNaPokedex
// ═══════════════════════════════════════════════════════════════
class Pokemon implements RegistravelNaPokedex {
  // Q1 — Atributos públicos (identificação do pokémon)
  final int numero;
  String nome;
  String tipo;

  // Q2 — Atributos privados (só acessados via getters/métodos)
  // O _ antes do nome torna o atributo privado em Dart
  int _nivel;
  int _hpAtual;
  int _hpMaximo;

  // Q7 — Energia necessária para usar habilidades
  int energia;

  // Q9 — Atributos de registro na Pokédex
  bool capturado;
  bool visto;
  bool favorito;

  // Q3 — Atributos de evolução (? significa que pode ser null)
  String? proximaEvolucao;
  int nivelEvolucao;

  // Q1 — Construtor com validações via assert
  // assert lança erro se a condição for false (funciona como proteção)
  Pokemon({
    required this.numero,
    required this.nome,
    required this.tipo,
    required int nivel,
    required int hpAtual,
    required int hpMaximo,
    this.capturado = false,
    this.energia = 100,
    this.proximaEvolucao,
    this.nivelEvolucao = 0,
  })  : assert(nivel >= 1 && nivel <= 100, 'Nível deve ser entre 1 e 100'),
        assert(hpMaximo > 0, 'HP Máximo deve ser maior que 0'),
        assert(hpAtual <= hpMaximo, 'HP Atual não pode ser maior que HP Máximo'),
        _nivel = nivel,
        _hpAtual = hpAtual,
        _hpMaximo = hpMaximo,
        visto = capturado,
        favorito = false;

  // Q2 — Getters: permitem ler os atributos privados de fora, mas não alterar
  int get nivel => _nivel;
  int get hpAtual => _hpAtual;
  int get hpMaximo => _hpMaximo;

  // Q6 — Método que será sobrescrito pelas subclasses (polimorfismo)
  // Cada tipo de pokémon calcula o ataque de forma diferente
  int calcularAtaqueBase() => _nivel * 2;

  // Q2 — Sobe nível com validação: nunca passa de 100, nunca fica abaixo de 1
  // clamp(min, max) garante que o valor fique entre min e max
  void subirNivel(int quantidade) {
    if (quantidade <= 0) return;
    _nivel = (_nivel + quantidade).clamp(1, 100);
  }

  // Q2 — Recebe dano: HP nunca fica negativo
  void receberDano(int dano) {
    if (dano <= 0) return;
    _hpAtual = (_hpAtual - dano).clamp(0, _hpMaximo);
  }

  // Q2 — Cura: HP nunca ultrapassa o máximo
  void curar(int valor) {
    if (valor <= 0) return;
    _hpAtual = (_hpAtual + valor).clamp(0, _hpMaximo);
  }

  // Q3 — Evolução com todas as regras obrigatórias
  void evoluir() {
    if (proximaEvolucao == null) {
      print('[$nome] Sem evolução disponível.');
      return;
    }
    if (_nivel < nivelEvolucao) {
      print('[$nome] Nível insuficiente (atual: $_nivel, necessário: $nivelEvolucao).');
      return;
    }
    print('>>> $nome está evoluindo para $proximaEvolucao! <<<');
    nome = proximaEvolucao!;  // ! diz ao Dart que sabemos que não é null aqui
    proximaEvolucao = null;   // impede evoluir duas vezes
    _hpMaximo += 20;
    _hpAtual = _hpMaximo;
  }

  // Q1 — Exibe todas as informações do pokémon de forma organizada
  void exibirFicha() {
    print('');
    print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    print(' #${numero.toString().padLeft(3, '0')} $nome');
    print(' Tipo   : $tipo');
    print(' Nível  : $_nivel');
    print(' HP     : $_hpAtual / $_hpMaximo');
    print(' Energia: $energia');
    print(' Visto  : ${visto ? 'Sim' : 'Não'} | Capturado: ${capturado ? 'Sim' : 'Não'} | Favorito: ${favorito ? 'Sim' : 'Não'}');
    if (proximaEvolucao != null) {
      print(' Próxima evolução: $proximaEvolucao (nível $nivelEvolucao)');
    }
    print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
  }

  // Q9 — Implementação da interface RegistravelNaPokedex
  // @override indica que estamos substituindo o método da interface

  @override
  void marcarComoVisto() {
    visto = true;
    print('[$nome] Marcado como visto.');
  }

  @override
  void marcarComoCapturado() {
    visto = true;      // capturar automaticamente marca como visto
    capturado = true;
    print('[$nome] Capturado! (marcado como visto automaticamente)');
  }

  @override
  void favoritar() {
    if (!capturado) {
      print('[$nome] Não é possível favoritar: pokémon não foi capturado.');
      return;
    }
    favorito = true;
    print('[$nome] Adicionado aos favoritos!');
  }

  @override
  void desfavoritar() {
    favorito = false;
    print('[$nome] Removido dos favoritos.');
  }
}

// ═══════════════════════════════════════════════════════════════
// QUESTÃO 6 — Subclasses por tipo (Herança)
//
// Cada subclasse HERDA tudo de Pokemon e sobrescreve:
// - calcularAtaqueBase() com fórmula própria
// - exibirFicha() para mostrar a categoria do pokémon
// Isso é HERANÇA + SOBRESCRITA DE MÉTODOS
// ═══════════════════════════════════════════════════════════════

class PokemonFogo extends Pokemon {
  PokemonFogo({
    required super.numero,
    required super.nome,
    required super.hpAtual,
    required super.hpMaximo,
    required super.nivel,
    super.capturado,
    super.energia,
    super.proximaEvolucao,
    super.nivelEvolucao,
  }) : super(tipo: 'Fogo');

  @override
  int calcularAtaqueBase() => nivel * 3;  // Q6: fogo = nivel * 3

  @override
  void exibirFicha() {
    super.exibirFicha();  // chama o exibirFicha() da classe pai
    print(' Categoria: Pokémon de Fogo | Ataque Base: ${calcularAtaqueBase()}');
    print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
  }
}

class PokemonAgua extends Pokemon {
  PokemonAgua({
    required super.numero,
    required super.nome,
    required super.hpAtual,
    required super.hpMaximo,
    required super.nivel,
    super.capturado,
    super.energia,
    super.proximaEvolucao,
    super.nivelEvolucao,
  }) : super(tipo: 'Água');

  @override
  int calcularAtaqueBase() => nivel * 2 + 10;  // Q6: água = nivel * 2 + 10

  @override
  void exibirFicha() {
    super.exibirFicha();
    print(' Categoria: Pokémon de Água | Ataque Base: ${calcularAtaqueBase()}');
    print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
  }
}

class PokemonEletrico extends Pokemon {
  PokemonEletrico({
    required super.numero,
    required super.nome,
    required super.hpAtual,
    required super.hpMaximo,
    required super.nivel,
    super.capturado,
    super.energia,
    super.proximaEvolucao,
    super.nivelEvolucao,
  }) : super(tipo: 'Elétrico');

  @override
  int calcularAtaqueBase() => nivel * 2 + 15;  // Q6: elétrico = nivel * 2 + 15

  @override
  void exibirFicha() {
    super.exibirFicha();
    print(' Categoria: Pokémon Elétrico | Ataque Base: ${calcularAtaqueBase()}');
    print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
  }
}
