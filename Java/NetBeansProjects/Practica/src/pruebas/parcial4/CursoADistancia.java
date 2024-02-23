/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pruebas.parcial4;

public class CursoADistancia extends Curso{
    private String linkSala;

    public CursoADistancia(int año, int cantidadAlumnos, String linkSala){
        super(año, cantidadAlumnos);
        this.linkSala = linkSala;
    }

    public String getLinkSala() {
        return linkSala;
    }

    public void setLinkSala(String linkSala) {
        this.linkSala = linkSala;
    }
    
    @Override
    public boolean puedeRendir(Alumno alumno){
        return alumno.getAutoevaluacionesAprobadas() == 3 && alumno.getAsistencias()>=1;
    }
}
