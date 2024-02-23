/*
 Queremos representar libros electrónicos e impresos. De cualquier libro se conoce:
título, precio base y el nombre de los autores (a lo sumo 8).
 */
package pruebas.parcial3;

public abstract class Libro {
    private String titulo;
    private double precioBase;
    private String[] nombreAutores;
    private int dimlNombreAutores;
    
    public Libro(String titulo, double precioBase){
        this.titulo=titulo;
        this.precioBase=precioBase;
        this.nombreAutores= new String[8];
        this.dimlNombreAutores=0;
    }

    public String getTitulo() {
        return titulo;
    }

    public double getPrecioBase() {
        return precioBase;
    }

    public int getDimlNombreAutores() {
        return dimlNombreAutores;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public void setPrecioBase(double precioBase) {
        this.precioBase = precioBase;
    }
    
    private String obtenerNombreAutor(int pos){
        return this.nombreAutores[pos];
    }
    
    public void agregarAutor(String nombreAutor){
        this.nombreAutores[getDimlNombreAutores()] = nombreAutor;   //Se asume que hay espacio
        this.dimlNombreAutores++;
    }
    
    //Obtener la representación String del libro, la cual se compone de título, precio final y nombre de sus autores.
    @Override
    public String toString(){
        String aux= getTitulo() + " - " +
                    "$" + this.obtenerPrecioFinal() +
                    "\nAutores:\n";
        
        for(int i=0; i<getDimlNombreAutores(); i++)
            aux+= obtenerNombreAutor(i) + "\n";
        
        return aux;
    }
    
    public abstract double obtenerPrecioFinal();
}
