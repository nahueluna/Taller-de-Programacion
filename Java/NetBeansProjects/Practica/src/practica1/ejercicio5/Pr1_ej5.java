/*
El dueño de un restaurante entrevista a cinco clientes y les pide que califiquen
(con puntaje de 1 a 10) los siguientes aspectos: (0) Atención al cliente (1) Calidad
de la comida (2) Precio (3) Ambiente.
Escriba un programa que lea desde teclado las calificaciones de los cinco clientes
para cada uno de los aspectos y almacene la información en una estructura. Luego
imprima la calificación promedio obtenida por cada aspecto.
 */
package practica1.ejercicio5;

import PaqueteLectura.GeneradorAleatorio;
public class Pr1_ej5 {

    public static void main(String[] args) {
        int[][]calificaciones=new int[5][4];
        int cliente,aspecto,sumaCalificaciones;
        sumaCalificaciones=0;
        
        GeneradorAleatorio.iniciar();
        //Cargar calificaciones
        for(cliente=0;cliente<5;cliente++)
            for(aspecto=0;aspecto<4;aspecto++)
                calificaciones[cliente][aspecto]=GeneradorAleatorio.generarInt(10)+1;
        
        //Calcular promedios de aspectos
        for(aspecto=0;aspecto<4;aspecto++){
            for(cliente=0;cliente<5;cliente++)
                sumaCalificaciones=sumaCalificaciones+calificaciones[cliente][aspecto];
            System.out.println("La calificacion promedio para el aspecto "+aspecto+" es "+((double)sumaCalificaciones/5));
            sumaCalificaciones=0;
        }
    }
    
}
