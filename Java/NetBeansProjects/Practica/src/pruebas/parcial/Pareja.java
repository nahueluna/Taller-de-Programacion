/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pruebas.parcial;

public class Pareja {
    private Participante participante1;
    private Participante participante2;
    private String estiloBaile;
    
    public Pareja(Participante participante1, Participante participante2, String estiloBaile){
        this.participante1= participante1;
        this.participante2= participante2;
        this.estiloBaile= estiloBaile;
    }

    public Participante getParticipante1() {
        return participante1;
    }

    public Participante getParticipante2() {
        return participante2;
    }

    public String getEstiloBaile() {
        return estiloBaile;
    }
    
    public int devolverDiferenciaEdad(){
        return Math.abs(participante1.getEdad() - participante2.getEdad()); //devuelve valor absoluto
    }
}
