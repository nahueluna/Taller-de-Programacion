/*
Escriba un programa que instancie un coro de cada tipo. Lea o bien la cantidad de
coristas (en el caso del coro semicircular) o la cantidad de hileras e integrantes por
hilera (en el caso del coro por hileras). Luego cree la cantidad de coristas necesarios,
leyendo sus datos, y almacenándolos en el coro. Finalmente imprima toda la
información de los coros indicando si están bien formados o no.
 */
package repaso.ejercicio4;

import PaqueteLectura.Lector;
import PaqueteLectura.GeneradorAleatorio;

public class repaso_ej4 {
    
    public static void main(String[] args) {
        CoroSemicircular coroSemCir;
        CoroPorHileras coroHileras;
        Director direc;
        Corista coris;
        
        direc= new Director("Paulo", 37653242, 35, 15);
        
        coroSemCir= new CoroSemicircular("All Boys", direc, 4);
        coroHileras= new CoroPorHileras("Coro Unido", direc, 3, 2);
        
        GeneradorAleatorio.iniciar();
        
        while(!coroSemCir.coroLleno()){
            System.out.println("Ingrese nombre y tono del corista semicircular: ");
            coris= new Corista(Lector.leerString(), GeneradorAleatorio.generarInt(100), GeneradorAleatorio.generarInt(25)+1, Lector.leerInt());
            coroSemCir.agregarCorista(coris);
        }
        
        while(!coroHileras.coroLleno()){
            System.out.println("Ingrese nombre y tono del corista por hilera: ");
            coris= new Corista(Lector.leerString(), GeneradorAleatorio.generarInt(100), GeneradorAleatorio.generarInt(25)+1, Lector.leerInt());
            coroHileras.agregarCorista(coris);
        }
        
        System.out.println();
        
        System.out.println(coroSemCir.toString());
        System.out.println("Coro semicircular bien formado: " + coroSemCir.coroBienFormado());
        
        System.out.println();
        System.out.println();
        
        System.out.println(coroHileras.toString());
        System.out.println("Coro por hileras bien formado: " + coroHileras.coroBienFormado());
    }
    
}
