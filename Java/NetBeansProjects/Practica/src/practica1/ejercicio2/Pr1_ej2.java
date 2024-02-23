/*
Escriba un programa que lea las alturas de los 15 jugadores de un equipo de
básquet y las almacene en un vector. Luego informe:
- la altura promedio
- la cantidad de jugadores con altura por encima del promedio
 */
package practica1.ejercicio2;

import PaqueteLectura.Lector;
public class Pr1_ej2 {

    public static void main(String[] args) {
        final int jugadores=5;
        
        double alturaJugadores[]=new double[jugadores], promedioAltura, sumaAltura=0;
        int i,cantidadMayorPromedio=0;
        
        for(i=0; i<jugadores; i++){
            System.out.println("Ingrese la altura del jugador " + (i+1));
            alturaJugadores[i]=Lector.leerDouble();  
            sumaAltura+=alturaJugadores[i];
        }
        promedioAltura= sumaAltura/jugadores;
        
        for(i=0; i<jugadores; i++)
            if(alturaJugadores[i]>promedioAltura)
                cantidadMayorPromedio++;
        
        System.out.println("El promedio de altura es de " + Math.round(promedioAltura*100)/100d);//multiplico por 100, redondeo y divido por 100 (salvo dos decimales)
        System.out.println("La cantidad de jugadores con altura mayor al promedio es de " + cantidadMayorPromedio);
    }
    
}
