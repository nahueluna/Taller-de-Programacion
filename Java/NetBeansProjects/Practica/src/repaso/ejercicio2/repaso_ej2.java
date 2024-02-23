/*
Realice un programa que instancie un estacionamiento con 3 pisos y 3 plazas por piso.
Registre 6 autos en el estacionamiento en distintos lugares.
Muestre la representación String del estacionamiento en consola.
Muestre la cantidad de autos ubicados en la plaza 1.
Lea una patente por teclado e informe si dicho auto se encuentra en el
estacionamiento o no. En caso de encontrarse, la información a imprimir es el piso y
plaza que ocupa.
 */
package repaso.ejercicio2;

import PaqueteLectura.GeneradorAleatorio;
import PaqueteLectura.Lector;

public class repaso_ej2 {

    public static void main(String[] args) {
        Estacionamiento estac;
        Auto vehiculo;
        
        GeneradorAleatorio.iniciar();
        
        System.out.println("Ingrese Nombre, Direccion, Hora de apertura, y Hora de cierre del estacionamiento: ");
        estac=new Estacionamiento(Lector.leerString(), Lector.leerString(), Lector.leerString(), Lector.leerString(), 3, 3);
        
        for(int i=0; i<6; i++){
            vehiculo=new Auto(GeneradorAleatorio.generarString(7), GeneradorAleatorio.generarString(6));
            estac.registrarAuto(vehiculo, GeneradorAleatorio.generarInt(3)+1, GeneradorAleatorio.generarInt(3)+1);
        }
        
        System.out.println(estac.toString());
        System.out.println();
        System.out.println("En la plaza 1 se ubicaron " + estac.cantidadDeAutosEnPlaza(1) + " autos.");
        System.out.println("Ingrese una patente: ");
        System.out.println(estac.devolverPosicionAuto(Lector.leerString()));
    }
    
}
