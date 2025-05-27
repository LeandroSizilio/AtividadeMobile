// No seu arquivo Tela2.java

package com.example.atividademobile; // Certifique-se de que este é o nome correto do seu pacote

import androidx.appcompat.app.AppCompatActivity;
import android.content.Intent;
import android.os.Bundle;
import android.widget.ImageButton; // Importe ImageButton
import android.widget.ImageView;

public class Tela2 extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_tela2); // Define o layout para activity_tela2.xml

        // Encontra o ImageButton com o ID "imageButton"
        ImageButton classesButton = findViewById(R.id.imageButton);

        // Define um OnClickListener para o ImageButton
        classesButton.setOnClickListener(v -> {
            // Cria uma Intent para iniciar a atividade Tela3
            Intent intent = new Intent(Tela2.this, Tela3.class);
            startActivity(intent); // Inicie a atividade Tela3
        });

        ImageView escudoImageView = findViewById(R.id.imageView); // Encontra a ImageView do escudo

        escudoImageView.setOnClickListener(v -> {
            // Crie uma Intent para iniciar a MainActivity
            Intent intent = new Intent(Tela2.this, MainActivity.class);
            startActivity(intent); // Inicie a MainActivity

            // Opcional: Se você quiser que a Tela2 seja finalizada e removida da pilha
            // ao voltar para a MainActivity através do escudo.
            // finish();
        });

        ImageButton fichasButton = findViewById(R.id.imageButton4);
        fichasButton.setOnClickListener(v -> {

            Intent intent = new Intent(Tela2.this, Tela3.class); // Altere para a tela desejada
            startActivity(intent);
        });
    }
}