/*
Escriba un programa que defina una matriz de enteros de tamaño 5x5. Inicialice
la matriz con números aleatorios entre 0 y 30.
Luego realice las siguientes operaciones:
- Mostrar el contenido de la matriz en consola.
- Calcular e informar la suma de los elementos de la fila 1
- Generar un vector de 5 posiciones donde cada posición j contiene la suma
de los elementos de la columna j de la matriz. Luego, imprima el vector.
- Lea un valor entero e indique si se encuentra o no en la matriz. En caso de
encontrarse indique su ubicación (fila y columna) en caso contrario
imprima “No se encontró el elemento”.
 */
package practica1.ejercicio3;

import PaqueteLectura.GeneradorAleatorio;
import PaqueteLectura.Lector;
public class Pr1_ej3 {

    public static void main(String[] args) {
        int[][]matriz=new int[5][5];
        int[]vector=new int[5];
        int i,j,sumaFila1=0,sumaColumna,valorBuscado;
        boolean valorExiste=false;
        
        GeneradorAleatorio.iniciar();
        //Cargar la matriz
        for(i=0; i<5; i++)
            for(j=0; j<5; j++)
                matriz[i][j]=GeneradorAleatorio.generarInt(31);
        
        //Imprimir matriz
        for(i=0; i<5; i++){
            for(j=0; j<5; j++)
                System.out.print(matriz[i][j] + "| ");
            System.out.println();
        }
        System.out.println();
        
        //Suma elementos fila 1
        for(i=0; i<5; i++)
            sumaFila1+=matriz[1][i];
        System.out.println("Los elementos de la fila 1 suman un total de " + sumaFila1);
        System.out.println();
        
        //Generar un vector de 5 posiciones donde cada posición j contiene la suma de los elementos de la columna j de la matriz
        for(i=0; i<5; i++){
            sumaColumna=0;
            for(j=0; j<5; j++)
                sumaColumna+=matriz[j][i];  //invierto indices para reccorer la columna en vez de la fila
            vector[i]=sumaColumna;
        }
        for(i=0; i<5; i++)
            System.out.println("Pos. " + i + " " + vector[i]);
        System.out.println();
        
        /*Lea un valor entero e indique si se encuentra o no en la matriz. En caso de encontrarse indique su ubicación (fila y columna), 
        en caso contrario imprima “No se encontró el elemento”*/
        System.out.println("Ingrese un valor a buscar: ");
        valorBuscado=Lector.leerInt();
        i=0;
        j=0;    //Sino no funciona correctamente
        while((i<5) && (!valorExiste)){
            j=0;
            while((j<5) && (!valorExiste)){   //Si encuentro el valor salgo del bucle. Sino recorro toda la estructura
                if(matriz[i][j]==valorBuscado)
                    valorExiste=true;
                j++;
            }
            i++;
        }
        if(valorExiste)
            System.out.println("El valor se encuentra en la fila " + (i-1) + " y columna " + (j-1));  //Resto 1 ya que antes de salir del bucle incremento
        else
            System.out.println("No se encontro el elemento");
    }
    
}
