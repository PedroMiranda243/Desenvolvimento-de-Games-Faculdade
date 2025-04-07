// ============================
// 1. Variáveis Globais
// ============================

int player1Score = 0; // Pontuação do jogador 1
int player2Score = 0; // Pontuação do jogador 2
int maxScore = 5; // Pontuação máxima para vencer

float paddleWidth; // Largura das palhetas
float paddleHeight; // Altura das palhetas
float p1Y, p2Y; // Posição vertical das palhetas
float p1Speed = 6, p2Speed = 6; // Velocidade das palhetas

float ballX, ballY; // Posição da bola
float ballSpeedX, ballSpeedY; // Velocidade da bola
float ballSize = 20; // Tamanho da bola

String gameState = "menu"; // Estado atual: "menu", "jogando", "pause", "vitoria"
boolean versusBot = true; // Modo contra BOT ou dois jogadores
String winner = ""; // Nome do vencedor

String dificuldade = "Normal"; // Nível de dificuldade: "Fácil", "Normal", "Difícil"
float ballSpeedMin, ballSpeedMax, botSpeed; // Configurações baseadas na dificuldade

boolean trainingMode = false; // Modo treino (não conta pontos)

// Botões
Button btnContinuar, btnReiniciar, btnMenu;
Button btnContraBot, btnContraPlayer, btnTreino;
Button btnDificuldade;
Button btnMenuVitoria;

// ============================
// 2. Função setup()
// ============================

void setup() {
  size(1250, 720); // Define o tamanho da tela
  frameRate(60); // Define a taxa de quadros por segundo
  setupButtons(); // Configura os botões
  inicializarJogo(); // Inicializa o jogo
}

// ============================
// 3. Função setupButtons()
// ============================

void setupButtons() {
  // Cria os botões para o menu, pausa e tela de vitória
  btnContinuar = new Button("Continuar", width/2 - 75, 220, 150, 40);
  btnReiniciar = new Button("Reiniciar", width/2 - 75, 280, 150, 40);
  btnMenu = new Button("Menu", width/2 - 75, 340, 150, 40);

  btnContraBot = new Button("Jogar contra BOT", width/2 - 130, 240, 260, 60);
  btnContraPlayer = new Button("2 Jogadores", width/2 - 130, 320, 260, 60);
  btnTreino = new Button("Modo Treino", width/2 - 130, 400, 260, 60);
  btnDificuldade = new Button("Dificuldade: " + dificuldade, width/2 - 130, 480, 260, 60);

  btnMenuVitoria = new Button("Voltar ao Menu", width/2 - 100, height/2 + 40, 200, 40);
}

// ============================
// 4. Função configurarDificuldade()
// ============================

void configurarDificuldade() {
  // Ajusta as configurações de acordo com a dificuldade selecionada
  if (dificuldade.equals("Fácil")) {
    paddleHeight = 150;
    ballSpeedMin = 3;
    ballSpeedMax = 4;
    botSpeed = 2;
  } else if (dificuldade.equals("Normal")) {
    paddleHeight = 100;
    ballSpeedMin = 4;
    ballSpeedMax = 6;
    botSpeed = 4;
  } else if (dificuldade.equals("Difícil")) {
    paddleHeight = 60;
    ballSpeedMin = 6;
    ballSpeedMax = 8;
    botSpeed = 6;
  }
}

// ============================
// 5. Função inicializarJogo()
// ============================

void inicializarJogo() {
  configurarDificuldade(); // Define as configurações baseadas na dificuldade
  paddleWidth = 20; // Define a largura das palhetas
  p1Y = height/2 - paddleHeight/2; // Centraliza as palhetas
  p2Y = height/2 - paddleHeight/2;
  ballX = width/2; // Centraliza a bola
  ballY = height/2;
  ballSpeedX = random(1) > 0.5 ? random(ballSpeedMin, ballSpeedMax) : -random(ballSpeedMin, ballSpeedMax); // Velocidade inicial da bola
  ballSpeedY = random(-3, 3);
  player1Score = 0; // Zera as pontuações
  player2Score = 0;
  winner = ""; // Limpa o vencedor
}

// ============================
// 6. Função draw()
// ============================

void draw() {
  background(20, 20, 50); // Fundo escuro

  // Controla o estado atual do jogo
  if (gameState.equals("menu")) {
    desenharMenu();
  } else if (gameState.equals("jogando")) {
    atualizarJogo();
    desenharJogo();
  } else if (gameState.equals("pause")) {
    desenharJogo();
    desenharPausa();
  } else if (gameState.equals("vitoria")) {
    desenharVitoria();
  }
}

// ============================
// 7. Funções de Desenho
// ============================

void desenharMenu() {
  // Exibe o menu inicial com opções de modo de jogo e dificuldade
  fill(255);
  textAlign(CENTER);
  textSize(64);
  text("PONG", width/2, 150);
  textSize(24);
  text("Escolha um modo de jogo e a dificuldade", width/2, 200);

  btnContraBot.label = "Jogar contra BOT";
  btnContraPlayer.label = "2 Jogadores";
  btnTreino.label = trainingMode ? "Desativar Treino" : "Ativar Treino";
  btnDificuldade.label = "Dificuldade: " + dificuldade;

  btnContraBot.display();
  btnContraPlayer.display();
  btnTreino.display();
  btnDificuldade.display();
}

void desenharPausa() {
  // Exibe a tela de pausa com opções para continuar, reiniciar ou voltar ao menu
  fill(0, 180);
  rect(0, 0, width, height);
  fill(255);
  textAlign(CENTER);
  textSize(36);
  text("PAUSA", width/2, 150);
  btnContinuar.display();
  btnReiniciar.display();
  btnMenu.display();
}

void desenharVitoria() {
  // Exibe a tela de vitória com o nome do vencedor e opção para voltar ao menu
  fill(255);
  textAlign(CENTER);
  textSize(36);
  text("VENCEDOR: " + winner, width/2, height/2 - 40);
  textSize(20);
  text("Pressione 'M' ou clique para voltar ao menu", width/2, height/2);
  btnMenuVitoria.display();
}

void desenharJogo() {
  // Desenha a linha central, palhetas, bola e placar
  stroke(255);
  strokeWeight(2);
  for (int i = 0; i < height; i += 20) line(width/2, i, width/2, i+10);

  noStroke();
  fill(255);
  rect(0, p1Y, paddleWidth, paddleHeight);
  rect(width - paddleWidth, p2Y, paddleWidth, paddleHeight);
  ellipse(ballX, ballY, ballSize, ballSize);

  textSize(36);
  textAlign(CENTER);
  text(player1Score + " x " + player2Score, width/2, 50);

  textSize(16);
  text("Pressione ESC para pausar", width/2, height - 10);
}

// ============================
// 8. Função atualizarJogo()
// ============================

void atualizarJogo() {
  // Movimenta as palhetas dos jogadores
  if (keyPressed) {
    if (key == 'w') p1Y -= p1Speed;
    if (key == 's') p1Y += p1Speed;

    if (!versusBot) {
      if (keyCode == UP) p2Y -= p2Speed;
      if (keyCode == DOWN) p2Y += p2Speed;
    }
  }

  // Limita as palhetas dentro da tela
  p1Y = constrain(p1Y, 0, height - paddleHeight);
  p2Y = constrain(p2Y, 0, height - paddleHeight);

  // Movimento do BOT
  if (versusBot) {
    float erro = map(abs(ballSpeedX), ballSpeedMin, ballSpeedMax, 50, 10); // Mais rápido = menos erro
    float alvo = ballY + random(-erro, erro);
    float centroBot = p2Y + paddleHeight / 2;

    if (centroBot < alvo - 5) {
      p2Y += botSpeed;
    } else if (centroBot > alvo + 5) {
      p2Y -= botSpeed;
    }
  }

  // Movimenta a bola
  ballX += ballSpeedX;
  ballY += ballSpeedY;

  // Colisão com as bordas superior e inferior
  if (ballY < 0 || ballY > height) ballSpeedY *= -1;

  // Colisão com as palhetas
  if (ballX < paddleWidth && ballY > p1Y && ballY < p1Y + paddleHeight) ballSpeedX *= -1;
  if (ballX > width - paddleWidth && ballY > p2Y && ballY < p2Y + paddleHeight) ballSpeedX *= -1;

  // Verifica se a bola saiu da tela
  if (ballX < 0) {
    if (!trainingMode) player2Score++;
    resetarBola();
  }
  if (ballX > width) {
    if (!trainingMode) player1Score++;
    resetarBola();
  }

  // Verifica se alguém venceu
  if (player1Score >= maxScore) {
    gameState = "vitoria";
    winner = "Jogador 1";
  } else if (player2Score >= maxScore) {
    winner = versusBot ? "BOT" : "Jogador 2";
    gameState = "vitoria";
  }
}

// ============================
// 9. Função resetarBola()
// ============================

void resetarBola() {
  // Reseta a posição e velocidade da bola
  ballX = width/2;
  ballY = height/2;
  ballSpeedX = random(1) > 0.5 ? random(ballSpeedMin, ballSpeedMax) : -random(ballSpeedMin, ballSpeedMax);
  ballSpeedY = random(-3, 3);
}

// ============================
// 10. Funções de Entrada
// ============================

void keyPressed() {
  // Lida com eventos de teclado
  if (key == ESC) {
    key = 0;
    if (gameState.equals("jogando")) {
      gameState = "pause";
    } else if (gameState.equals("pause")) {
      gameState = "jogando";
    }
    return;
  }

  if (gameState.equals("vitoria")) {
    if (key == 'm' || key == 'M') {
      gameState = "menu";
    }
  }
}

void mousePressed() {
  // Lida com cliques nos botões
  if (gameState.equals("pause")) {
    if (btnContinuar.isMouseOver()) {
      gameState = "jogando";
    } else if (btnReiniciar.isMouseOver()) {
      inicializarJogo();
      gameState = "jogando";
    } else if (btnMenu.isMouseOver()) {
      gameState = "menu";
    }
  } else if (gameState.equals("menu")) {
    if (btnContraBot.isMouseOver()) {
      versusBot = true;
      inicializarJogo();
      gameState = "jogando";
    } else if (btnContraPlayer.isMouseOver()) {
      versusBot = false;
      inicializarJogo();
      gameState = "jogando";
    } else if (btnTreino.isMouseOver()) {
      trainingMode = !trainingMode;
    } else if (btnDificuldade.isMouseOver()) {
      if (dificuldade.equals("Fácil")) dificuldade = "Normal";
      else if (dificuldade.equals("Normal")) dificuldade = "Difícil";
      else dificuldade = "Fácil";
    }
  } else if (gameState.equals("vitoria")) {
    if (btnMenuVitoria.isMouseOver()) {
      gameState = "menu";
    }
  }
}

// ============================
// 11. Classe Button
// ============================

class Button {
  String label;
  float x, y, w, h;

  Button(String label, float x, float y, float w, float h) {
    this.label = label;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }

  void display() {
    // Desenha o botão com destaque se o mouse estiver sobre ele
    fill(isMouseOver() ? color(255, 215, 0) : color(255));
    stroke(50);
    strokeWeight(2);
    rect(x, y, w, h, 12);
    fill(0);
    textAlign(CENTER, CENTER);
    textSize(20);
    text(label, x + w/2, y + h/2);
  }

  boolean isMouseOver() {
    // Verifica se o mouse está sobre o botão
    return mouseX >= x && mouseX <= x + w && mouseY >= y && mouseY <= y + h;
  }
}
