/*
Un edificio de oficinas está conformado por 8 pisos (1..8) y 4 oficinas por piso
(1..4). Realice un programa que permita informar la cantidad de personas que
concurrieron a cada oficina de cada piso. Para esto, simule la llegada de personas al
edificio de la siguiente manera: a cada persona se le pide el nro. de piso y nro. de
oficina a la cual quiere concurrir. La llegada de personas finaliza al indicar un nro.
de piso 9. Al finalizar la llegada de personas, informe lo pedido.
 */
package practica1.ejercicio4;

import PaqueteLectura.Lector;
public class Pr1_ej4 {


    public static void main(String[] args) {
        int[][]edificio=new int[8][4];
        int piso,oficina;
        
        //Inicializo matriz
        for(piso=0;piso<8;piso++)
            for(oficina=0;oficina<4;oficina++)
                edificio[piso][oficina]=0;
        
        //Cuenta cantidad de personas por piso y oficina
        System.out.println("Ingrese piso y oficina");
        piso=Lector.leerInt();
        oficina=Lector.leerInt();
        while(piso<9 && piso>0){
            edificio[piso-1][oficina-1]++;
            piso=Lector.leerInt();
            if(piso<9 && piso>0)
                oficina=Lector.leerInt();
        }
        
        //Informa cantidad de personas por piso y oficina
        for(piso=0;piso<8;piso++)
            for(oficina=0;oficina<4;oficina++)
                System.out.println("El piso " + (piso+1) + " y oficina " + (oficina+1) + " tiene " + edificio[piso][oficina] + " personas.");
    }
    
}
