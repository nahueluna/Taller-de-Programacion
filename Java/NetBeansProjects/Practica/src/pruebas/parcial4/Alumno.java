/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pruebas.parcial4;

public class Alumno {
    private String nombre;
    private int DNI;
    private int asistencias;
    private int autoevaluacionesAprobadas;
    
    public Alumno(String nombre, int DNI){
        this.nombre=nombre;
        this.DNI=DNI;
        this.asistencias=0;
        this.autoevaluacionesAprobadas=0;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public int getDNI() {
        return DNI;
    }

    public void setDNI(int DNI) {
        this.DNI = DNI;
    }

    public int getAsistencias() {
        return asistencias;
    }

    public int getAutoevaluacionesAprobadas() {
        return autoevaluacionesAprobadas;
    }
    
    public void aumentoAsistencia(){
        this.asistencias++;
    }
    
    public void aumentoAutoevaluacionAprobada(){
        this.autoevaluacionesAprobadas++;
    }
}
