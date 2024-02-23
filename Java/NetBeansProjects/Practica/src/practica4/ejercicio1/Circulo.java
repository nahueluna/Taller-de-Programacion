/*
De igual manera, incluya la clase Círculo a la jerarquía de figuras.
 */
package practica4.ejercicio1;

public class Circulo extends Figura{
    private double radio;
    
    public Circulo(double radio, String colorRelleno, String colorLinea){
        super(colorRelleno, colorLinea);
        this.setRadio(radio);
    }

    public double getRadio() {
        return radio;
    }

    public void setRadio(double radio) {
        this.radio = radio;
    }
    
    @Override
    public String toString(){
        String aux = super.toString() +
                     " Radio: " + this.getRadio();
        
        return aux;
    }
    
    @Override
    public double calcularPerimetro(){
        return 2 * Math.PI * getRadio();
    }
    @Override
    public double calcularArea(){
        return Math.PI * Math.pow(getRadio(), 2);
    }
}
