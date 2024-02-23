/*
Se realizará un casting para un programa de TV. El casting durará a lo sumo 5 días y en
cada día se entrevistarán a 8 personas en distinto turno.
a) Simular el proceso de inscripción de personas al casting. A cada persona se le pide
nombre, DNI y edad y se la debe asignar en un día y turno de la siguiente manera: las
personas primero completan el primer día en turnos sucesivos, luego el segundo día y así
siguiendo. La inscripción finaliza al llegar una persona con nombre “ZZZ” o al cubrirse los
40 cupos de casting.
Una vez finalizada la inscripción:
b) Informar para cada día y turno asignado, el nombre de la persona a entrevistar.
NOTA: utilizar la clase Persona. Pensar en la estructura de datos a utilizar. Para comparar
Strings use el método equals
 */
package practica2.ejercicio3;

import PaqueteLectura.Lector;
import PaqueteLectura.GeneradorAleatorio;
public class Pr2_ej3 {

    public static void main(String[] args) {
        Persona[][] entrevistados=new Persona[5][8];
        int dimL=0, dia=0, turno=0,i,j=0;
        String nombreLeido;
        boolean seguir=true;
        
        GeneradorAleatorio.iniciar();
        
        System.out.print("Ingrese el nombre: ");
        nombreLeido=Lector.leerString();
        
        while((dia<5) && (!nombreLeido.equals("ZZZ"))){
            while((turno<8) && (!nombreLeido.equals("ZZZ"))){
                entrevistados[dia][turno]=new Persona();
            
                entrevistados[dia][turno].setNombre(nombreLeido);
                System.out.print("Ingrese el DNI: ");
                entrevistados[dia][turno].setDNI(Lector.leerInt());
                System.out.print("Ingrese la edad: ");
                entrevistados[dia][turno].setEdad(Lector.leerInt());
                
                dimL++;
                turno++;
                
                System.out.print("Ingrese el nombre: ");
                nombreLeido=Lector.leerString();
                System.out.println();
            }
            turno=0;
            dia++;
        }
        /* 
        El for principal me permite iterar desde el dia 0 hasta dia-1. Dia tendrá la cantidad de días que se cargaron, por lo que debo ir hasta
        el anterior, considerando que el índice empieza en 0. Luego, j recorrerá hasta que se alcance la ultima fila(ultimo dia) y el valor de columna
        indicado por el resto de la cantidad de elementos por la cantidad de columnas (resulta en cantidad de columnas con datos en la ultima fila) y
        le resto 1 para tener el indice de esa última columna cargada. En caso de que la matriz esté vacía, nunca ingresará al primer for. Si la matriz
        está totalmente llena o al menos alguna fila lo está, nunca ingresará al if (porque (dimL % 8) - 1 = -1), por lo que recorrerá del 0 al 7 las 
        columnas, asegurandose recorrer la fila en su totalidad.
        */
        for(i=0; i<dia; i++){
            while((j<8) && (seguir)){
                if((i==(dia-1)) && (j==(dimL % 8)-1))
                    seguir=false;
                
                System.out.println("Dia: " + (i+1) + ", Turno: " + (j+1) + " - " + entrevistados[i][j].toString());
                
                j++;
            }
            j=0;
        }
    }
    
}
