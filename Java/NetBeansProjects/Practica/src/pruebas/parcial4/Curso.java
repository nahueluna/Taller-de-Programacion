/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pruebas.parcial4;


public abstract class Curso {
    private int año;
    private Alumno[] alumnos;
    private int cantidadAlumnos;
    private int dimlAlumnos;
    
    public Curso(int año, int cantidadAlumnos){
        this.año=año;
        this.cantidadAlumnos= cantidadAlumnos;
        this.alumnos = new Alumno[this.cantidadAlumnos];
        this.dimlAlumnos=0;
    }

    public int getAño() {
        return año;
    }

    public void setAño(int año) {
        this.año = año;
    }

    public int getCantidadAlumnos() {
        return cantidadAlumnos;
    }

    public int getDimlAlumnos() {
        return dimlAlumnos;
    }
    
    private boolean aulaLlena(){
        return getDimlAlumnos() == getCantidadAlumnos();
    }
    
    private Alumno obtenerAlumno(int pos){
        return this.alumnos[pos];
    }
    
    public boolean agregarAlumno(Alumno alumno){
        boolean agregado=false;
        
        if(!aulaLlena()){
            this.alumnos[getDimlAlumnos()] = alumno;
            this.dimlAlumnos++;
            
            agregado = true;
        }
        
        return agregado;
    }
    
    public void incrementarAsistencia(int DNI){
        boolean aluEncontrado=false;
        int indiceAlu=0;
        
        while(indiceAlu<getDimlAlumnos() && !aluEncontrado)
            if(obtenerAlumno(indiceAlu).getDNI() == DNI){
                obtenerAlumno(indiceAlu).aumentoAsistencia();
                aluEncontrado=true;
            }
            else indiceAlu++;
    }
    
    public void aprobarAutoevaluacion(int DNI){
        boolean aluEncontrado=false;
        int indiceAlu=0;
        
        while(indiceAlu<getDimlAlumnos() && !aluEncontrado)
            if(obtenerAlumno(indiceAlu).getDNI() == DNI){
                obtenerAlumno(indiceAlu).aumentoAutoevaluacionAprobada();
                aluEncontrado=true;
            }
            else indiceAlu++;
    }
    
    public int cantidadDeAlumnosQuePuedenRendir(){
        int cantHabilitados=0;
        
        for(int i=0; i<getDimlAlumnos(); i++)
            if(this.puedeRendir(obtenerAlumno(i)))
                cantHabilitados++;
        
        return cantHabilitados;
    }
    
    public abstract boolean puedeRendir(Alumno alumno);
}
