/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pruebas.parcial3;

public class LibroElectronico extends Libro{
    private String formato;
    private double MB;
    
    public LibroElectronico(String titulo, double precioBase, String formato, double MB){
        super(titulo, precioBase);
        this.formato=formato;
        this.MB=MB;
    }

    public String getFormato() {
        return formato;
    }

    public double getMB() {
        return MB;
    }

    public void setFormato(String formato) {
        this.formato = formato;
    }

    public void setMB(double MB) {
        this.MB = MB;
    }
    
    //Para los libros electrónicos es el precio base al que se adiciona un impuesto de descarga de 2,5$ por MB.
    @Override
    public double obtenerPrecioFinal(){
        return getPrecioBase() + (2.5*getMB());
    }
    
}
