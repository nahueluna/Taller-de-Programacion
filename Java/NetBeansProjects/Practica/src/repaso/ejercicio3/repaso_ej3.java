/*
Realice un programa que instancie un evento ocasional y una gira, cargando la
información necesaria. Luego, para ambos, imprima el costo e invoque al mensaje actuar
 */
package repaso.ejercicio3;

import PaqueteLectura.Lector;

public class repaso_ej3 {

    public static void main(String[] args) {
        Gira gira;
        EventoOcasional evento;
        Fecha fecha;
        
        System.out.println("Ingrese nombre de la gira, cantidad de fechas, nombre de la banda y cantidad de temas: ");
        gira= new Gira(Lector.leerString(), Lector.leerInt(), Lector.leerString(), Lector.leerInt());
        
        System.out.println("Ingrese nombre de la banda, cantidad de temas, motivo, contratante y dia del evento: ");
        evento= new EventoOcasional(Lector.leerString(), Lector.leerInt(), Lector.leerString(), Lector.leerString(), Lector.leerInt());
    
        while(!gira.listaTemaLlena()){
            System.out.println("Ingrese un tema: ");
            gira.agregarTema(Lector.leerString());
        }
        
        while(!gira.fechasLlenas()){
            System.out.println("Ingrese una ciudad y dia: ");
            fecha= new Fecha(Lector.leerString(), Lector.leerInt());
            gira.agregarFecha(fecha);
        }
        
        while(!evento.listaTemaLlena()){
            System.out.println("Ingrese un tema: ");
            evento.agregarTema(Lector.leerString());
        }
        
        System.out.println(gira.actuar());
        System.out.println("El costo de la gira es de $" + gira.calcularCosto());
        
        System.out.println();
        System.out.println();
        
        System.out.println(evento.actuar());
        System.out.println("El costo del evento ocasional es de $" + evento.calcularCosto());
        
        
    }
    
}
