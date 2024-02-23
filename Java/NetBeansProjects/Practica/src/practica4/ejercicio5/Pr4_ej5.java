/*
Realice un programa que instancie el visor, guarde dos cuadrados y un rectángulo en el
visor y por último haga que el visor muestre sus figuras almacenadas.
 */
package practica4.ejercicio5;

public class Pr4_ej5 {

    public static void main(String[] args) {
        VisorFigurasModificado visor = new VisorFigurasModificado();
        Figura c1 = new Cuadrado(5.5, "Rojo", "Negro");
        Figura c2 = new Cuadrado(2.7, "Verde", "Violeta");
        Figura r = new Rectangulo(6.7, 1.5, "Amarillo", "Celeste");
        
        visor.guardar(c1);
        visor.guardar(c2);
        visor.guardar(r);
        
        visor.mostrar();
    }
    
}
