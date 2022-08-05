import 'questao.dart';

List<Map> _conjuntoQuestoes = [
  {
    "enunciado": "Qual foi faturamento dos e-Sports no Brasil em 2021?",
    "respostaCorreta": "Mais de 2,5 bilhões de reais",
    "outrasOpcoes": [
      "900 milhões de reais",
      "1.2 bilhões de reais",
      "725 milhões de reais"
    ]
  },
  {
    "enunciado": "Qual foi o único brasileiro a se tornar o GOAT dos e-Sports?",
    "respostaCorreta": "Coldzera",
    "outrasOpcoes": ["Gaules", "Nesk", "Netenho"]
  },
  {
    "enunciado":
        "e-Sports: Em questão público, o país se encontra em qual colocação do ranking?",
    "respostaCorreta": "3º Lugar",
    "outrasOpcoes": ["18º Lugar", "1º Lugar", "13º Lugar"]
  },
  {
    "enunciado": "e-Sports: Qual é a plataforma mais jogada atualmente?",
    "respostaCorreta": "Mobile",
    "outrasOpcoes": ["Console", "Notebook", "Desktop"]
  },
  {
    "enunciado":
        "e-Sports: Em que ano a SK Gaming trouxe o segundo major para o Brasil?",
    "respostaCorreta": "2016",
    "outrasOpcoes": ["2015", "2017", "2018"]
  },
  {
    "enunciado": "e-Sports: Qual é o time com o maior engajamento do CSGO?",
    "respostaCorreta": "Imperial",
    "outrasOpcoes": ["Astralis", "Natus Vincere", "Vitality"]
  },
  {
    "enunciado":
        "CSGO: Qual a foi a primeira plataforma em que Fallen se tornou um dos sócios?",
    "respostaCorreta": "GamesAcademy",
    "outrasOpcoes": ["GamersClub", "Faceit", "ESEA"]
  },
  {
    "enunciado": "Crossfire: Em que ano a VINCIT Gaming foi para o mundial?",
    "respostaCorreta": "2019",
    "outrasOpcoes": ["2018", "2020", "2022"]
  },
  {
    "enunciado":
        "Crossfire: Em que ano a VINCIT Gaming se tornou campeã mundial?",
    "respostaCorreta": "2019",
    "outrasOpcoes": ["2017", "2016", "2020"]
  },
  {
    "enunciado": "e-Sports: Em que jogo se encontra o MVP do CFS 2019?",
    "respostaCorreta": "Valorant",
    "outrasOpcoes": ["LoL", "CS:GO", "Crossfire"]
  },
];

class QuestaoRepositorio {
  List<Questao> geraQuestoes(int qtde) {
    List<Questao> questoes = [];

    _conjuntoQuestoes.shuffle();

    for (int i = 0; (i < qtde) && (i < _conjuntoQuestoes.length); i++) {
      var selecionada = _conjuntoQuestoes[i];

      var questao = Questao(
          enunciado: selecionada["enunciado"],
          respostaCorreta: selecionada["respostaCorreta"],
          opcoes: [
            ...selecionada["outrasOpcoes"],
            selecionada["respostaCorreta"]
          ]..shuffle());

      questoes.add(questao);
    }

    return questoes;
  }
}
