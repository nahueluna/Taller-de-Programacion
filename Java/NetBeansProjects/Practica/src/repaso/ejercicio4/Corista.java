/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package repaso.ejercicio4;

public class Corista extends Persona{
    private int tono;

    public Corista(String nombre, int DNI, int edad, int tono) {
        super(nombre, DNI, edad);
        this.tono = tono;
    }

    public int getTono() {
        return tono;
    }
    
    @Override
    public String toString(){
        String aux= super.toString();
        aux+= " Tono fundamental: " + getTono() + ".";
        
        return aux;
    }
}
