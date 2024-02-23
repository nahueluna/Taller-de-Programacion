/*
Definir una clase para representar triángulos. Un triángulo se caracteriza por el
tamaño de sus 3 lados (double), el color de relleno (String) y el color de línea (String).
Provea un constructor que reciba todos los datos necesarios para iniciar el objeto.
Provea métodos para:
- Devolver/modificar el valor de cada uno de sus atributos (métodos get y set)
- Calcular el perímetro y devolverlo (método calcularPerimetro)
- Calcular el área y devolverla (método calcularArea)
 */
package practica3.ejercicio1;

public class Triangulo {
    private double lado1;
    private double lado2;
    private double lado3;
    private String colorRelleno;
    private String colorLinea;
    
    public Triangulo(){
        
    }

    public Triangulo(double lado1, double lado2, double lado3, String colorRelleno, String colorLinea){
        this.lado1=lado1;
        this.lado2=lado2;
        this.lado3=lado3;
        this.colorRelleno=colorRelleno;
        this.colorLinea=colorLinea;
    }
    
    public double getLado1(){
        return this.lado1;
    }
    public void setLado1(double lado1){
        this.lado1=lado1;
    }
    
    public double getLado2(){
        return this.lado2;
    }
    public void setLado2(double lado2){
        this.lado2=lado2;
    }
    
    public double getLado3(){
        return this.lado3;
    }
    public void setLado3(double lado3){
        this.lado3=lado3;
    }
    
    public String getColorRelleno(){
        return this.colorRelleno;
    }
    public void setColorRelleno(String colorRelleno){
        this.colorRelleno=colorRelleno;
    }
    
    public String getColorLinea(){
        return this.colorLinea;
    }
    public void setColorLinea(String colorLinea){
        this.colorLinea=colorLinea;
    }
    
    public double calcularPerimetro(){
        return (this.lado1 + this.lado2 + this.lado3);
    }
    
    public double calcularArea(){
        double aux=this.calcularPerimetro()/2;
        aux=aux*(aux - this.lado1)*(aux - this.lado2)*(aux - this.lado3);
        return Math.sqrt(aux);  //√s(s − a)(s − b)(s − c)
    }
    
}
