/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pruebas.parcial2;

import PaqueteLectura.Lector;
import PaqueteLectura.GeneradorAleatorio;

public class ParcialMain {

    public static void main(String[] args) {
        Paciente p;
        Agenda a=new Agenda();
        String nombreLeido;
        int contadorPacientes=0, diaLeido, turnoLeido;
        
        System.out.println("Ingrese nombre del paciente: ");
        nombreLeido=Lector.leerString();
    
        GeneradorAleatorio.iniciar();
        
        while(!nombreLeido.equals("ZZZ") && contadorPacientes<(5*6)){
            p = new Paciente(nombreLeido, GeneradorAleatorio.generarBoolean(), GeneradorAleatorio.generarDouble(5000)+5000);
            System.out.println("Ingrese turno: ");
            turnoLeido=Lector.leerInt();
            System.out.println("Dia asignado: " + a.agendarPacienteTurnoLibre(p, turnoLeido));
            
            System.out.println("Ingrese nombre del paciente");
            nombreLeido=Lector.leerString();
            contadorPacientes++;
        }
            
        System.out.println("Ingrese el paciente a liberar turnos y el dia: ");
        a.liberarTurnoPacienteEnDia(Lector.leerString(), Lector.leerInt());
        
        System.out.println("Ingrese nombre del paciente a buscar: ");
        nombreLeido=Lector.leerString();
        System.out.println("Cantidad de turno del paciente: " + a.cantidadTurnosPaciente(nombreLeido));
    }
    
}
