/*
Realice un programa que instancie un libro electrónico y un libro impreso. Cargue 3
autores a cada uno. Para finalizar, muestre la representación String de los libros.
 */
package pruebas.parcial3;

import PaqueteLectura.Lector;

public class ParcialMain {

    public static void main(String[] args) {
        LibroElectronico ebook;
        LibroImpreso book;
        
        System.out.println("Ingrese titulo, precio base, formato y MB del libro electronico: ");
        ebook = new LibroElectronico(Lector.leerString(), Lector.leerDouble(), Lector.leerString(), Lector.leerDouble());
        
        System.out.println("Ingrese un titulo, precio base y si es tapa dura para el libro impreso ");
        book = new LibroImpreso(Lector.leerString(), Lector.leerDouble(), Lector.leerBoolean());
        
        for(int i=0; i<3; i++){
            System.out.println("Ingrese nombre de un autor para el ebook: ");
            ebook.agregarAutor(Lector.leerString());
            
            System.out.println("Ingrese nombre de un autor para el libro impreso: ");
            book.agregarAutor(Lector.leerString());
        }
        
        System.out.println();
        
        System.out.println(ebook.toString());
        
        System.out.println();
        
        System.out.println(book.toString());
    }
    
}
