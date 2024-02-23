/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package repaso.ejercicio4;

public class Director extends Persona{
    private int antiguedad;

    public Director(String nombre, int DNI, int edad, int antiguedad) {
        super(nombre, DNI, edad);
        this.antiguedad = antiguedad;
    }

    public int getAntiguedad() {
        return antiguedad;
    }
    
    @Override
    public String toString(){
        String aux= super.toString();
        aux+= " Antigüedad: " + getAntiguedad() + " años.";
        
        return aux;
                   
    }
}
