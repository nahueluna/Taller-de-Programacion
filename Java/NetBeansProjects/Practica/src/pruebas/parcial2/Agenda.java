/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pruebas.parcial2;

public class Agenda {
    private Paciente[][] turnosSemana;
    private int dias;
    private int turnos;

    public Agenda() {
        this.turnosSemana= new Paciente[5][6];
        this.dias=5;
        this.turnos=6;
        
        //Inicializa sin pacientes
        for(int i=0; i<getDias(); i++)
            for(int j=0; j<getTurnos(); j++)
                this.turnosSemana[i][j]=null;
    }

    public int getDias() {
        return dias;
    }

    public int getTurnos() {
        return turnos;
    }
    
    private Paciente obtenerPaciente(int posDia, int posTurno){
        return this.turnosSemana[posDia][posTurno];
    }
    
    public void agendarPaciente(Paciente paciente, int dia, int turno){
        this.turnosSemana[dia-1][turno-1]= paciente;
    }
    
    /*Agendar al paciente P en el primer día que tenga libre el turno T. Retornar el día
    asignado. Asuma que hay un día con dicho turno libre y que T es válido.*/
    public int agendarPacienteTurnoLibre(Paciente paciente, int turno){
        boolean turnoLibre=false;
        int indiceDia=0;
        
        while(indiceDia<getDias() && !turnoLibre){
            if(obtenerPaciente(indiceDia, turno)==null){
                this.turnosSemana[indiceDia][turno]=paciente;
                turnoLibre=true;
            }
                
            else indiceDia++;
        }
        
        return indiceDia+1;
    }
    
    public int liberarTurnosPaciente(String nombre){
        Paciente pacienteTemp;
        int cantEliminado=0;
        
        for(int i=0; i<getDias(); i++)
            for(int j=0; j<getTurnos(); j++){
                pacienteTemp=obtenerPaciente(i, j);
                if(pacienteTemp!=null)
                    if(pacienteTemp.getNombre().equals(nombre)){
                        this.turnosSemana[i][j]=null;
                        cantEliminado++;
                    }
            }
        
        return cantEliminado;
    }
    
    //Dado un día D y el nombre de un paciente, liberar el turno ocupado por el paciente en ese día.
    public void liberarTurnoPacienteEnDia(String nombre, int dia){
        boolean encontrado=false;
        int indiceTurno=0;
        
        while(indiceTurno<getTurnos() && !encontrado){
            if(obtenerPaciente(dia, indiceTurno)!=null)
                if(obtenerPaciente(dia, indiceTurno).getNombre().equals(nombre)){
                    this.turnosSemana[dia][indiceTurno]=null;
                    encontrado=true;
                }
            indiceTurno++;
        }
    }
    
    public boolean verificarTurnoPaciente(String nombre, int dia){
        boolean pacienteEncontrado=false;
        int indiceTurno=0;
        Paciente pacienteTemp;
        
        
        while(indiceTurno<getTurnos() && !pacienteEncontrado){
            pacienteTemp=obtenerPaciente(dia-1, indiceTurno);
            if(pacienteTemp!=null)
                if(pacienteTemp.getNombre().equals(nombre))
                    pacienteEncontrado=true;
            indiceTurno++;
        }
        
        return pacienteEncontrado;
    }
    
    public int cantidadTurnosPaciente(String nombre){
        int cantidadTurnos=0;
        
        for(int i=0; i<getDias(); i++)
            for(int j=0; j<getTurnos(); j++){
                if(obtenerPaciente(i, j)!=null)
                    if(obtenerPaciente(i, j).getNombre().equals(nombre))
                        cantidadTurnos++;
            }
        
        return cantidadTurnos;
                
    }
    
}
