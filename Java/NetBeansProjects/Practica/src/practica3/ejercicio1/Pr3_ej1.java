/*
Realizar un programa que instancie un triángulo, le cargue información leída desde
teclado e informe en consola el perímetro y el área.
*/
package practica3.ejercicio1;

import PaqueteLectura.Lector;

public class Pr3_ej1 {

    public static void main(String[] args) {
        Triangulo tri;
        
        System.out.println("Ingrese los 3 lados del triangulo, su color de relleno y su color de linea: ");
        tri= new Triangulo(Lector.leerDouble(),Lector.leerDouble(),Lector.leerDouble(),Lector.leerString(),Lector.leerString());
        
        System.out.println("El perimetro del triangulo es " + tri.calcularPerimetro());
        System.out.println("El area del triangulo es " + tri.calcularArea());
    }
    
}
