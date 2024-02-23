/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pruebas.parcial;

public class Participante {
    private String nombre;
    private int DNI;
    private int edad;
    
    public Participante(String nombre, int DNI, int edad){
        this.nombre=nombre;
        this.DNI=DNI;
        this.edad=edad;
    }

    public String getNombre() {
        return nombre;
    }

    public int getDNI() {
        return DNI;
    }

    public int getEdad() {
        return edad;
    }
    
    
}
