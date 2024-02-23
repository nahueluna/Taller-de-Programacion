/*
Realice un programa que instancie un estante. Cargue varios libros. A partir del estante,
busque e informe el autor del libro “Mujercitas”
 */
package practica3.ejercicio3;

import PaqueteLectura.Lector;

public class Pr3_ej3 {

    public static void main(String[] args) {
        Estante estante=new Estante();
        Libro libroLeido;
        Autor autorLeido;
        String tituloLeido;
        
        System.out.println("Ingrese titulo del libro: ");
        tituloLeido=Lector.leerString();
        while(!estante.estanteLleno() && !tituloLeido.equals("ZZZ")){
            System.out.println("Ingrese nombre, biografia y origen del autor");
            autorLeido=new Autor(Lector.leerString(), Lector.leerString(), Lector.leerString());
            System.out.println("Ingrese editorial e ISBN del libro");
            libroLeido=new Libro(tituloLeido, Lector.leerString(), autorLeido, Lector.leerString());
            
            estante.agregarLibro(libroLeido);
            
            System.out.println("Ingrese titulo del libro: ");
            tituloLeido=Lector.leerString();
        }
        
        libroLeido=estante.devolverLibro("Mujercitas");
        
        if(libroLeido!=null)
            System.out.println(libroLeido.getPrimerAutor().toString());
        else
            System.out.println("El libro de titulo 'Mujercitas' no se encontro");
    }
    
}
