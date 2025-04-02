package JogoDaVelha;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class JogoDaVelhaGUI extends JFrame {
    private JButton[][] botoes = new JButton[3][3];
    private char jogadorAtual = 'X';
    private boolean jogoAtivo = true;
    private JLabel statusLabel;

    public JogoDaVelhaGUI() {
        setTitle("Jogo da Velha");
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setSize(300, 350);
        setLayout(new BorderLayout());

        // Painel de status
        statusLabel = new JLabel("Vez do Jogador " + jogadorAtual, SwingConstants.CENTER);
        statusLabel.setFont(new Font("Arial", Font.BOLD, 16));
        add(statusLabel, BorderLayout.NORTH);

        // Painel do tabuleiro
        JPanel tabuleiroPanel = new JPanel(new GridLayout(3, 3));
        tabuleiroPanel.setBorder(BorderFactory.createEmptyBorder(10, 10, 10, 10));

        // Cria os botões do tabuleiro
        for (int linha = 0; linha < 3; linha++) {
            for (int coluna = 0; coluna < 3; coluna++) {
                JButton botao = new JButton();
                botao.setFont(new Font("Arial", Font.PLAIN, 48));
                botao.setFocusPainted(false);
                botao.addActionListener(new BotaoClickListener(linha, coluna));
                botoes[linha][coluna] = botao;
                tabuleiroPanel.add(botao);
            }
        }

        add(tabuleiroPanel, BorderLayout.CENTER);
        setVisible(true);
    }

    private class BotaoClickListener implements ActionListener {
        private int linha;
        private int coluna;

        public BotaoClickListener(int linha, int coluna) {
            this.linha = linha;
            this.coluna = coluna;
        }

        @Override
        public void actionPerformed(ActionEvent e) {
            JButton botaoClicado = (JButton) e.getSource();

            if (botaoClicado.getText().isEmpty() && jogoAtivo) {
                botaoClicado.setText(String.valueOf(jogadorAtual));

                if (verificarVencedor()) {
                    statusLabel.setText("Jogador " + jogadorAtual + " venceu!");
                    jogoAtivo = false;
                } else if (verificarEmpate()) {
                    statusLabel.setText("Empate!");
                    jogoAtivo = false;
                } else {
                    trocarJogador();
                    statusLabel.setText("Vez do Jogador " + jogadorAtual);
                }
            }
        }
    }

    private void trocarJogador() {
        jogadorAtual = (jogadorAtual == 'X') ? 'O' : 'X';
    }

    private boolean verificarVencedor() {
        // Verifica linhas e colunas
        for (int i = 0; i < 3; i++) {
            if (checarCombinacao(botoes[i][0], botoes[i][1], botoes[i][2]) ||
                    checarCombinacao(botoes[0][i], botoes[1][i], botoes[2][i])) {
                return true;
            }
        }

        // Verifica diagonais
        return checarCombinacao(botoes[0][0], botoes[1][1], botoes[2][2]) ||
                checarCombinacao(botoes[0][2], botoes[1][1], botoes[2][0]);
    }

    private boolean checarCombinacao(JButton b1, JButton b2, JButton b3) {
        return !b1.getText().isEmpty() &&
                b1.getText().equals(b2.getText()) &&
                b2.getText().equals(b3.getText());
    }

    private boolean verificarEmpate() {
        for (int i = 0; i < 3; i++) {
            for (int j = 0; j < 3; j++) {
                if (botoes[i][j].getText().isEmpty()) {
                    return false;
                }
            }
        }
        return true;
    }

    public static void main(String[] args) {
        SwingUtilities.invokeLater(() -> new JogoDaVelhaGUI());
    }
}