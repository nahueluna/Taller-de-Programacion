/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pruebas.parcial3;

public class LibroImpreso extends Libro{
    private boolean esTapaDura;

    public LibroImpreso(String titulo, double precioBase, boolean esTapaDura) {
        super(titulo, precioBase);
        this.esTapaDura = esTapaDura;
    }

    public boolean isEsTapaDura() {
        return esTapaDura;
    }

    public void setEsTapaDura(boolean esTapaDura) {
        this.esTapaDura = esTapaDura;
    }
    
    //Para los libros impresos es el precio base al que se adiciona 500$ si es de tapa dura.
    @Override
    public double obtenerPrecioFinal(){
        double auxPrecio=getPrecioBase();
        if(isEsTapaDura())
            auxPrecio+= 500;
        
        return auxPrecio;
    }
}
