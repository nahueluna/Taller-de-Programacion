/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pruebas.parcial4;

import PaqueteLectura.Lector;

public class ParcialMain {

    public static void main(String[] args) {
        CursoADistancia cursoDistancia = new CursoADistancia(5, 6, "qwerty");
        CursoPresencial cursoPresencial = new CursoPresencial(3, 4, 8);
        Alumno alum;
        int DNIleido;
        
        
        for(int i=0; i<6; i++){
            System.out.println("Ingrese nombre y DNI del alumno para clase a distancia: ");
            alum = new Alumno(Lector.leerString(), Lector.leerInt());
            cursoDistancia.agregarAlumno(alum);
        }
        
        for(int i=0; i<4; i++){
            System.out.println("Ingrese nombre y DNI del alumno para clase presencial: ");
            alum = new Alumno(Lector.leerString(), Lector.leerInt());
            cursoPresencial.agregarAlumno(alum);
        }
         
        System.out.println("Ingrese un DNI: ");
        DNIleido = Lector.leerInt();
        while(DNIleido != 0){
            cursoDistancia.incrementarAsistencia(DNIleido);
            cursoDistancia.aprobarAutoevaluacion(DNIleido);
            
            cursoPresencial.incrementarAsistencia(DNIleido);
            cursoPresencial.aprobarAutoevaluacion(DNIleido);
            
            System.out.println("Ingrese un DNI: ");
            DNIleido = Lector.leerInt();
        }
        
        alum = new Alumno("Jacinto", 375235);
        System.out.println("¿Pude agregar alumno?: " + cursoDistancia.agregarAlumno(alum));
        
        System.out.println();
        
        System.out.println("La cantidad de alumnos habilitados a rendir en el curso a distancia es de: " + cursoDistancia.cantidadDeAlumnosQuePuedenRendir());
        
        System.out.println();
        
        System.out.println("La cantidad de alumnos habilitados a rendir en el curso presencial es de: " + cursoPresencial.cantidadDeAlumnosQuePuedenRendir());
    }
    
}
