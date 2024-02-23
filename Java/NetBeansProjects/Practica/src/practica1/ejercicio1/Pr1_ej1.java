/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package practica1.ejercicio1;

import PaqueteLectura.GeneradorAleatorio;
public class Pr1_ej1 {

    public static void main(String[] args) {
        int DF=11;  
        int [] tabla2 = new int[DF]; // indices de 0 a 10
        int i;
        int indice;
        
        for (i=0;i<DF;i++) 
            tabla2[i]=2*i;
    
        GeneradorAleatorio.iniciar();
        indice=GeneradorAleatorio.generarInt(12);
        while(indice!=11){
            System.out.println("2x" + indice + " = " + tabla2[indice]);
            indice=GeneradorAleatorio.generarInt(12);
        }
    }
    
}
