/*
Incluya la clase Triángulo a la jerarquía de figuras vista (carpeta tema4). Triángulo
debe heredar de Figura todo lo que es común y definir su constructor y sus atributos y
métodos propios. Además debe redefinir el método toString.
 */
package practica4.ejercicio1;

public class Triangulo extends Figura{
    private double lado1;
    private double lado2;
    private double lado3;
    
    public Triangulo(double lado1, double lado2, double lado3, String colorRelleno, String colorLinea){
        super(colorRelleno, colorLinea);
        this.setLado1(lado1);
        this.setLado2(lado2);
        this.setLado3(lado3);
    }

    public double getLado1() {
        return lado1;
    }

    public void setLado1(double lado1) {
        this.lado1 = lado1;
    }

    public double getLado2() {
        return lado2;
    }

    public void setLado2(double lado2) {
        this.lado2 = lado2;
    }

    public double getLado3() {
        return lado3;
    }

    public void setLado3(double lado3) {
        this.lado3 = lado3;
    }
    
    @Override
    public String toString(){
        String aux;
        aux= super.toString() +
             " Lado 1: " + this.getLado1() +
             " Lado 2: " + this.getLado2() +
             " Lado 3: " + this.getLado3();   
        
        return aux;
    }
    
    @Override
    public double calcularPerimetro(){
        return(this.getLado1() + this.getLado2() +  this.getLado3());
    }
    @Override
    public double calcularArea(){
        double aux=this.calcularPerimetro()/2;
        aux=aux*(aux - this.getLado1())*(aux - this.getLado2())*(aux - this.getLado3());
        return Math.sqrt(aux);  //√s(s − a)(s − b)(s − c)
    }
}
