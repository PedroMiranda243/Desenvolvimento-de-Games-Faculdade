package JogoMarciano;

import java.util.Random;
import java.util.Scanner;

public class Marciano {
    public static void main(String[] args) {
        // Configuração inicial
        Random random = new Random();
        Scanner scanner = new Scanner(System.in);

        int numeroMarciano = random.nextInt(100) + 1; // Número aleatório entre 1 e 100
        int tentativas = 0;
        int palpite;

        System.out.println("🌌 *Jogo do JogoMarciano.Marciano* 🌌");
        System.out.println("Um marciano está escondido em uma árvore numerada de 1 a 100. Encontre-o!");

        // Loop principal do jogo
        do {
            System.out.print("\nDigite o número da árvore: ");
            palpite = scanner.nextInt();
            tentativas++;

            if (palpite < numeroMarciano) {
                System.out.println("🚀 O marciano está em uma árvore com número MAIOR!");
            } else if (palpite > numeroMarciano) {
                System.out.println("🚀 O marciano está em uma árvore com número MENOR!");
            }
        } while (palpite != numeroMarciano);

        // Mensagem de vitória
        System.out.println("\n🎉 *Parabéns!* Você encontrou o marciano na árvore " + numeroMarciano + "!");
        System.out.println("📊 Tentativas realizadas: " + tentativas);

        scanner.close();
    }
}