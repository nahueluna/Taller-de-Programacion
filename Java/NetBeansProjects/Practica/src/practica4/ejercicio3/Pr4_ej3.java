/*
Realice un programa que instancie una persona y un trabajador y muestre la
representación de cada uno en consola
 */
package practica4.ejercicio3;

public class Pr4_ej3 {

    public static void main(String[] args) {
        Persona p1 = new Persona("Mauro",38765872,25);
        Persona t1 = new Trabajador("Juan", 25346891, 35, "Alfarero");
        
        System.out.println(p1.toString());
        System.out.println(t1.toString());
    }
    
}
