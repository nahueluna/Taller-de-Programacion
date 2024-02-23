/*
Sobre un nuevo programa, modifique el ejercicio anterior para considerar que:
a) Durante el proceso de inscripción se pida a cada persona sus datos (nombre, DNI, edad)
y el día en que se quiere presentar al casting. La persona debe ser inscripta en ese día, en el 
siguiente turno disponible. En caso de no existir un turno en ese día, informe la situación. 
La inscripción finaliza al llegar una persona con nombre “ZZZ” o al cubrirse los 40 cupos 
de casting.
Una vez finalizada la inscripción:
b) Informar para cada día: la cantidad de inscriptos al casting ese día y el nombre de la 
persona a entrevistar en cada turno asignado.
 */
package practica2.ejercicio4;

import PaqueteLectura.Lector;
import PaqueteLectura.GeneradorAleatorio;

public class Pr2_ej4 {

    public static void main(String[] args) {
        final int cantMaxima=40;
        Persona[][] entrevistados=new Persona[5][8];
        int cantCasting=0;
        String nombreLeido;
        int dia;
        int h;
        int cantInscriptos;
        
        GeneradorAleatorio.iniciar();
        //Inicializo matriz
        for(int i=0; i<5; i++)
            for(int j=0; j<8; j++)
                entrevistados[i][j]=null;
        
        System.out.println("Ingrese un nombre: ");
        nombreLeido=Lector.leerString();
        while(!nombreLeido.equals("ZZZ") && cantCasting < cantMaxima){
            System.out.println("Ingrese un dia de 1 a 5: ");
            dia=Lector.leerInt();
            h=0;
            while(h < 8 && entrevistados[dia-1][h]!=null)
                h=h+1;
            if(h!=8){
                System.out.println("Ingrese DNI y edad: ");
                entrevistados[dia-1][h]= new Persona(nombreLeido, Lector.leerInt(), Lector.leerInt());
                cantCasting=cantCasting+1;
            }else{
                System.out.println("Este dia no tiene turno disponible");
            }
            System.out.println("Ingrese un nombre: ");
            nombreLeido=Lector.leerString();
        }
        
        for(int i=0; i<5; i++){
            cantInscriptos=0;
            for(int j=0; j<8; j++){
                if(entrevistados[i][j]!=null){
                    cantInscriptos=cantInscriptos+1;
                    System.out.println("Dia: " + (i+1) + ", Turno: " + (j+1) + " - " + entrevistados[i][j].toString());
                }
            }
            System.out.println("La cantidad de personas en el dia " + (i+1) + " es de " + cantInscriptos);
        }
    }
    
}
