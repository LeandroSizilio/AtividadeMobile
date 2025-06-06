// No seu arquivo Tela3.java

package com.example.atividademobile; // Certifique-se de que este é o nome correto do seu pacote

import androidx.appcompat.app.AppCompatActivity;
import android.content.Intent;
import android.os.Bundle;
import android.widget.Button; // Importe Button

public class Tela3 extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_tela3); // Define o layout para activity_tela3.xml

        // Encontre o Button com o ID "button"
        Button backButton = findViewById(R.id.button_voltar);

        // Defina um OnClickListener para o botão "Voltar"
        backButton.setOnClickListener(v -> {
            // Opção 1: Usar Intent para ir para a Tela2.
            // Esta é uma maneira explícita de voltar e recria a Tela2 se ela não estiver na pilha.
            Intent intent = new Intent(Tela3.this, Tela2.class);
            startActivity(intent);

            // Opção 2: Apenas finalizar a atividade atual (Tela3).
            // Se a Tela2 foi a atividade que chamou a Tela3,
            // `finish()` retornará para a Tela2 que já estava na pilha,
            // o que é mais eficiente e geralmente o comportamento desejado para um botão "Voltar".
            // Descomente a linha abaixo e comente as duas linhas acima se preferir este comportamento.
            // finish();
        });

        // Você pode adicionar listeners para os ImageButtons da classe (Guerreiro, Mago, Ladino, Clérigo) aqui também,
        // se eles precisarem ir para outras telas de detalhe, por exemplo.
    }
}