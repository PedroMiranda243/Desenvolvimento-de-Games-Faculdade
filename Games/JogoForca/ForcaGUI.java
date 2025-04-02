package JogoForca;

import javax.swing.*;
import java.awt.*;
import java.util.Arrays;

public class ForcaGUI extends JFrame {
    private String palavraSecreta = "JAVA";
    private char[] letrasDescobertas;
    private int tentativasRestantes = 6;
    private StringBuilder letrasErradas = new StringBuilder();

    private JPanel enforcadoPanel;
    private JLabel palavraLabel;
    private JTextField letraField;
    private JButton tentarButton;

    public ForcaGUI() {
        setTitle("Jogo da Forca");
        setSize(400, 400);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLayout(new BorderLayout());

        letrasDescobertas = new char[palavraSecreta.length()];
        Arrays.fill(letrasDescobertas, '_');

        // Painel do desenho do enforcado
        enforcadoPanel = new JPanel() {
            @Override
            protected void paintComponent(Graphics g) {
                super.paintComponent(g);
                desenharForca(g);
            }
        };
        enforcadoPanel.setPreferredSize(new Dimension(200, 200));

        // Painel de controle
        JPanel controlePanel = new JPanel();
        palavraLabel = new JLabel(String.valueOf(letrasDescobertas));
        palavraLabel.setFont(new Font("Arial", Font.BOLD, 24));

        letraField = new JTextField(1);
        tentarButton = new JButton("Tentar");

        tentarButton.addActionListener(e -> processarTentativa());

        controlePanel.add(new JLabel("Letra:"));
        controlePanel.add(letraField);
        controlePanel.add(tentarButton);

        add(enforcadoPanel, BorderLayout.CENTER);
        add(palavraLabel, BorderLayout.NORTH);
        add(controlePanel, BorderLayout.SOUTH);

        setVisible(true);
    }

    private void desenharForca(Graphics g) {
        g.setColor(Color.BLACK);
        // Base
        g.fillRect(50, 250, 100, 10);
        // Poste vertical
        g.fillRect(100, 50, 10, 200);
        // Braço horizontal
        g.fillRect(100, 50, 80, 10);
        // Corda
        g.drawLine(170, 50, 170, 70);

        if (tentativasRestantes < 6) { // Cabeça
            g.drawOval(155, 70, 30, 30);
        }
        if (tentativasRestantes < 5) { // Corpo
            g.drawLine(170, 100, 170, 170);
        }
        if (tentativasRestantes < 4) { // Braço esquerdo
            g.drawLine(170, 120, 140, 140);
        }
        if (tentativasRestantes < 3) { // Braço direito
            g.drawLine(170, 120, 200, 140);
        }
        if (tentativasRestantes < 2) { // Perna esquerda
            g.drawLine(170, 170, 140, 200);
        }
        if (tentativasRestantes < 1) { // Perna direita
            g.drawLine(170, 170, 200, 200);
        }
    }

    private void processarTentativa() {
        String input = letraField.getText().toUpperCase();
        letraField.setText("");

        if (input.length() != 1 || !Character.isLetter(input.charAt(0))) {
            JOptionPane.showMessageDialog(this, "Digite uma única letra!");
            return;
        }

        char letra = input.charAt(0);
        boolean acertou = false;

        for (int i = 0; i < palavraSecreta.length(); i++) {
            if (palavraSecreta.charAt(i) == letra) {
                letrasDescobertas[i] = letra;
                acertou = true;
            }
        }

        if (!acertou) {
            tentativasRestantes--;
            letrasErradas.append(letra).append(" ");
        }

        palavraLabel.setText(String.valueOf(letrasDescobertas));
        enforcadoPanel.repaint();

        verificarFimJogo();
    }

    private void verificarFimJogo() {
        if (String.valueOf(letrasDescobertas).equals(palavraSecreta)) {
            JOptionPane.showMessageDialog(this, "Parabéns! Você ganhou!");
            System.exit(0);
        } else if (tentativasRestantes == 0) {
            JOptionPane.showMessageDialog(this, "Game Over! A palavra era: " + palavraSecreta);
            System.exit(0);
        }
    }

    public static void main(String[] args) {
        new ForcaGUI();
    }
}