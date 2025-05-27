package com.example.atividademobile;

import androidx.appcompat.app.AppCompatActivity;
import android.content.Intent;
import android.graphics.drawable.AnimationDrawable;
import android.os.Bundle;
import android.os.Handler;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;

public class MainActivity extends AppCompatActivity {

    private ImageView keyAnimationView;
    private AnimationDrawable keyAnimation;
    private ImageView fechaduraImageView;

    // Se forem 5 frames * 170ms = 850ms
    private static final long ANIMATION_TOTAL_DURATION = 850; // Confirme esta duração!

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        fechaduraImageView = findViewById(R.id.Fechadura);
        keyAnimationView = findViewById(R.id.key_animation_view);

        // NENHUMA ATRIBUIÇÃO DE BACKGROUND/SRC AQUI AINDA
        // keyAnimationView.setBackgroundResource(R.drawable.key_unlock_animation);
        // keyAnimation = (AnimationDrawable) keyAnimationView.getBackground();

        keyAnimationView.setVisibility(View.GONE); // Garante que a chave não esteja visível no início

        fechaduraImageView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                fechaduraImageView.setClickable(false); // Desabilita clique na fechadura

                // ATRIBUIÇÃO E INICIALIZAÇÃO DA ANIMAÇÃO AGORA, NO CLIQUE:
                keyAnimationView.setImageResource(0); // Garante que não há imagem anterior
                keyAnimationView.setBackgroundResource(R.drawable.key_unlock_animation); // Atribui a animação
                keyAnimation = (AnimationDrawable) keyAnimationView.getBackground(); // Obtém a instância

                keyAnimationView.setVisibility(View.VISIBLE); // Torna a chave visível

                // Garante que a animação comece do zero e seja iniciada após a view estar desenhada
                if (keyAnimation.isRunning()) {
                    keyAnimation.stop();
                }
                keyAnimation.selectDrawable(0); // Garante que o primeiro frame seja o inicial

                keyAnimationView.post(new Runnable() {
                    @Override
                    public void run() {
                        keyAnimation.start(); // Inicia a animação
                    }
                });

                new Handler().postDelayed(new Runnable() {
                    @Override
                    public void run() {
                        keyAnimationView.setVisibility(View.GONE); // Esconde a animação da chave
                        fechaduraImageView.setClickable(true); // Re-habilita o clique

                        // Vai para a Tela2
                        Intent intent = new Intent(MainActivity.this, Tela2.class);
                        startActivity(intent);
                        // finish(); // Opcional
                    }
                }, ANIMATION_TOTAL_DURATION);
            }
        });

        // Se tiver o TextView Leandro e Felipe, ele não precisa de listener
    }
}