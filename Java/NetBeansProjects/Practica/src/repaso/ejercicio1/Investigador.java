/*
De cada investigador se tiene: nombre completo, categoría (1 a 5) y especialidad. 
Además, cualquier investigador puede pedir hasta un máximo de 5 subsidios
 */
package repaso.ejercicio1;

public class Investigador {
    private String nombre;
    private int categoria;  //asumo que está entre 1-5?
    private String especialidad;
    private Subsidio[] subsidiosPedidos;
    private int cantidadSubsidios;
    
    public Investigador(String nombre, int categoria, String especialidad){
        this.nombre=nombre;
        this.categoria=categoria;
        this.especialidad=especialidad;
        this.cantidadSubsidios=0;
        this.subsidiosPedidos=new Subsidio[5];
        for(int i=0; i<5; i++)
            this.subsidiosPedidos[i]=null;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public int getCategoria() {
        return categoria;
    }

    public void setCategoria(int categoria) {
        this.categoria = categoria;
    }

    public String getEspecialidad() {
        return especialidad;
    }

    public void setEspecialidad(String especialidad) {
        this.especialidad = especialidad;
    }

    public int getCantidadSubsidios() {
        return cantidadSubsidios;
    }
    
    private Subsidio devolverSubsidio(int posicion){
        return this.subsidiosPedidos[posicion];
    }
    
    public boolean cupoSubsidiosLleno(){
        return this.cantidadSubsidios == 5;
    }
    
    public void agregarSubsidio(Subsidio unSubsidio){
        if(!this.cupoSubsidiosLleno()){
            this.subsidiosPedidos[this.cantidadSubsidios]=unSubsidio;
            this.cantidadSubsidios++;
        }
    }
    
    public double devolverSubsidiosInvestigador(){
        double montoSubsidios=0;
        for(int j=0; j<this.getCantidadSubsidios();j++)
            if(this.devolverSubsidio(j).isEstado())
                montoSubsidios+=this.devolverSubsidio(j).getMonto();
        
        return montoSubsidios;
    }
    
    public void aprobarSubsidios(){
        for(int i=0; i<this.getCantidadSubsidios(); i++)
            this.subsidiosPedidos[i].setEstado(true);
    }
    
    /*La siguiente información de cada investigador: nombre, categoría, especialidad, 
    y el total de dinero de sus subsidios otorgados.*/
    @Override
    public String toString(){
        String aux= this.getNombre() + " - " +
                    this.getCategoria() + ", " +
                    this.getEspecialidad() +
                    ". Monto de subsidios: " + this.devolverSubsidiosInvestigador();
        
        return aux;
    }
}
