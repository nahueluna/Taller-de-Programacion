/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pruebas.parcial;

import PaqueteLectura.Lector;
import PaqueteLectura.GeneradorAleatorio;

public class ConcursoPrograma {

    public static void main(String[] args) {
        ConcursoBaile concurso= new ConcursoBaile(2);
        Pareja par1, par2;
        Participante part1, part2;
        
        GeneradorAleatorio.iniciar();
        
        System.out.println("Ingrese nombre y edad del participante 1: ");
        part1= new Participante(Lector.leerString(),GeneradorAleatorio.generarInt(100), Lector.leerInt());
        System.out.println("Ingrese nombre y edad del participante 2: ");
        part2= new Participante (Lector.leerString(),GeneradorAleatorio.generarInt(100), Lector.leerInt());
        System.out.println("Lea un estilo de baile: ");
        par1= new Pareja(part1, part2, Lector.leerString());
        
        System.out.println("Ingrese nombre y edad del participante 1: ");
        part1= new Participante(Lector.leerString(),GeneradorAleatorio.generarInt(100), Lector.leerInt());
        System.out.println("Ingrese nombre y edad del participante 2: ");
        part2= new Participante (Lector.leerString(),GeneradorAleatorio.generarInt(100), Lector.leerInt());
        System.out.println("Lea un estilo de baile: ");
        par2= new Pareja(part1, part2, Lector.leerString());
        
        concurso.agregarPareja(par1);
        concurso.agregarPareja(par2);
        
        part1=concurso.devolverParejaMayorDiferencia().getParticipante1();
        part2=concurso.devolverParejaMayorDiferencia().getParticipante2();
        System.out.println("La pareja con mayor diferencia de edad es: " + part1.getNombre() + " y " + part2.getNombre());
    }
    
}
