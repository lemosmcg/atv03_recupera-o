import 'package:flutter/material.dart';
import 'questao.dart';
import 'repositorio_questao.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Quiz APP",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        primarySwatch: Colors.purple,
      ),
      home: Home(),
    );
  }
}

enum StatusResposta { aguardando, respondida }

enum StatusQuiz { ocorrendo, completou, resultados }

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Questao> perguntas = QuestaoRepositorio().geraQuestoes(10);
  String opcaoSelecionada = "";
  StatusResposta statusResposta = StatusResposta.aguardando;
  StatusQuiz statusQuiz = StatusQuiz.ocorrendo;
  int perguntaAtual = 0;

  void proximaPergunta() {
    if (statusQuiz == StatusQuiz.ocorrendo) {
      setState(() {
        if (perguntaAtual < perguntas.length - 1) {
          perguntaAtual++;
        }

        if (perguntaAtual == perguntas.length - 1) {
          statusQuiz = StatusQuiz.completou;
        }
        statusResposta = StatusResposta.aguardando;
        opcaoSelecionada = "";
      });
    } else {
      setState(() {
        statusQuiz = StatusQuiz.resultados;
      });
    }
  }

  void registraResposta(String opcao) {
    setState(() {
      if (statusResposta == StatusResposta.aguardando) {
        opcaoSelecionada = opcao;
        statusResposta = StatusResposta.respondida;
      }
    });

    debugPrint("${opcaoSelecionada} ${statusResposta}");
  }

  void reinicia() {
    setState(() {
      perguntas = QuestaoRepositorio().geraQuestoes(5);
      opcaoSelecionada = "";
      statusResposta = StatusResposta.aguardando;
      statusQuiz = StatusQuiz.ocorrendo;
      perguntaAtual = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quiz APP"),
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Pergunta ${perguntaAtual + 1}/${perguntas.length}",
                style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const Divider(
                height: 10,
                thickness: 2.0,
                color: Colors.black,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  perguntas[perguntaAtual].enunciado,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0XFF972ae6)),
                  textAlign: TextAlign.center,
                ),
              ),
              Divider(
                height: 10,
                thickness: 2.0,
                color: Colors.black,
              ),
              ...perguntas[perguntaAtual].opcoes.map(
                (opcao) {
                  return GestureDetector(
                    onTap: () {
                      registraResposta(opcao);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 50,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0XFF212121),
                        border: Border.all(
                          color: opcaoSelecionada == opcao
                              ? statusResposta == StatusResposta.respondida
                                  ? opcaoSelecionada ==
                                          perguntas[perguntaAtual]
                                              .respostaCorreta
                                      ? Colors.green
                                      : Colors.red
                                  : Colors.white
                              : Color(0XFF161616),
                          width: 3.0,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black,
                            offset: Offset(0, 2.0),
                            blurRadius: 5,
                          )
                        ],
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Text(
                        opcao,
                        style:
                            TextStyle(fontSize: 20, color: Color(0XFFc2c2c2)),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 60),
              statusResposta == StatusResposta.respondida
                  ? GestureDetector(
                      onTap: () {
                        //ir para a próxima pergunta
                        proximaPergunta();
                        print("Clicou na próxima ${perguntaAtual}");
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 200,
                        height: 50,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xFF626fbf),
                          border: Border.all(
                            color: Color(0xFF626fbf),
                            width: 3.0,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0, 2.0),
                              blurRadius: 5,
                            )
                          ],
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: statusQuiz == StatusQuiz.ocorrendo
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text("Próxima"),
                                  Icon(
                                    Icons.arrow_right,
                                    size: 50,
                                  ),
                                ],
                              )
                            : Text("Resultado"),
                      ),
                    )
                  : Container(
                      height: 70,
                      color: Colors.transparent,
                    )
            ],
          ),
        ),
      ),
    );
  }
}
