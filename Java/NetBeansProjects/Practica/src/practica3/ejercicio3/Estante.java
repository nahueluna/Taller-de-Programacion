/*
Defina una clase para representar estantes. Un estante almacena a lo sumo 20 libros.
Implemente un constructor que permita iniciar el estante sin libros. Provea métodos para:
(i) devolver la cantidad de libros almacenados (ii) devolver si el estante está lleno
(iii) agregar un libro al estante (iv) devolver el libro con un título particular que se recibe.
 */
package practica3.ejercicio3;

public class Estante {
    private Libro[] libros;
    private int dimL;
    
    public Estante() {
        this.libros=new Libro[20];
        for(int i=0; i<20; i++){
            //this.libros[i]=new Libro();
            this.libros[i]=null;
        }
        dimL=0;
    }
    
    public int cantidadLibros(){
        return this.dimL;
    }
    
    public boolean estanteLleno(){
        return this.dimL == 20;
    }
    
    public void agregarLibro(Libro libro){
        if(this.dimL<20){
            this.libros[dimL]=libro;
            dimL++;
        }   
    }
    
    private Libro unLibro(int indice){
        if(indice<this.dimL && indice>=0)
            return this.libros[indice];
        else
            return null;
    }
    
    public Libro devolverLibro(String titulo){
        int indice=0;
        boolean encontrado=false;
        while(indice<dimL && !encontrado){
            if(this.unLibro(indice).getTitulo().equals(titulo))
                encontrado=true;
            else indice++;
        }
        if(encontrado)
            return this.libros[indice];
        else
            return null;
    }
    
}
