/*
Realizar un programa que instancie un triángulo y un círculo. Muestre en consola la
representación String de cada uno. Pruebe el funcionamiento del método despintar.
 */
package practica4.ejercicio1;

import PaqueteLectura.Lector;

public class Pr4_ej1 {

    public static void main(String[] args) {
        System.out.println("Ingrese radio, color de relleno y color de linea del circulo: ");
        Figura c1=new Circulo(Lector.leerDouble(),Lector.leerString(),Lector.leerString());
        System.out.println("Ingrese medidas de los 3 lados, color de relleno y color de linea del triangulo: ");
        Figura t1=new Triangulo(Lector.leerDouble(), Lector.leerDouble(), Lector.leerDouble(), Lector.leerString(), Lector.leerString());
        
        System.out.println(c1.toString());
        System.out.println(t1.toString());
        
        c1.despintar();
        t1.despintar();
    
        System.out.println(c1.toString());
        System.out.println(t1.toString());
        
    }
    
}
