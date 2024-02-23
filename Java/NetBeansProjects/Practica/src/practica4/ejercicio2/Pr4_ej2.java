/*
Realizar un programa que instancie un jugador y un entrenador. Informe la
representación String de cada uno.
 */
package practica4.ejercicio2;

import PaqueteLectura.Lector;

public class Pr4_ej2 {

    public static void main(String[] args) {
        Empleado j1, e1;
        
        System.out.println("Ingrese nombre, sueldo, antigüedad, partidos y goles del jugador: ");
        j1= new Jugador(Lector.leerString(), Lector.leerDouble(), Lector.leerInt(), Lector.leerInt(), Lector.leerInt());
        
        System.out.println("Ingrese nombre, sueldo, antigüedad y campeonatos del entrenador: ");
        e1= new Entrenador(Lector.leerString(), Lector.leerDouble(), Lector.leerInt(), Lector.leerInt());
        
        System.out.println(j1.toString());
        System.out.println(e1.toString());
    }
    
}
