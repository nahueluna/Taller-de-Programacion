/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package repaso.ejercicio4;

public abstract class Coro {
    private String nombre;
    private Director director;
    
    public Coro(String nombre, Director director){
        this.nombre=nombre;
        this.director=director;
    }

    public String getNombre() {
        return nombre;
    }

    public Director getDirector() {
        return director;
    }
    
    @Override
    public String toString(){
        String aux= "Coro: " + getNombre() +
                    " - Director: " + getDirector().toString() + "\n" +
                    "Coristas:\n";
        
        return aux;
    }
    
    public abstract boolean coroLleno();
    public abstract void agregarCorista(Corista corista);
    public abstract boolean coroBienFormado();
}
