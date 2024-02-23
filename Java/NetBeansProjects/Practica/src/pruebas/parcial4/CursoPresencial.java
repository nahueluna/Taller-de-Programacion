/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pruebas.parcial4;

public class CursoPresencial extends Curso{
    private int numeroAula;

    public CursoPresencial(int año, int cantidadAlumnos, int numeroAula) {
        super(año, cantidadAlumnos);
        this.numeroAula = numeroAula;
    }

    public int getNumeroAula() {
        return numeroAula;
    }

    public void setNumeroAula(int numeroAula) {
        this.numeroAula = numeroAula;
    }
    
    @Override
    public boolean puedeRendir(Alumno alumno){
        return alumno.getAsistencias()>=3;
    }
}
