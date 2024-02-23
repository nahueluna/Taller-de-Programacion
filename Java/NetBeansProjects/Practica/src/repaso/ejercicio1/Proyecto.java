/*
Un proyecto tiene: nombre, código, nombre completo del director y los investigadores que participan
en el proyecto (50 como máximo).
 */
package repaso.ejercicio1;

public class Proyecto {
    private String nombreProyecto;
    private int codigo;
    private String nombreDirector;
    private Investigador [] investigadores;
    private int cantidadInvestigadores;
    
    public Proyecto(String nombreProyecto, int codigo, String nombreDirector){
        this.nombreProyecto=nombreProyecto;
        this.codigo=codigo;
        this.nombreDirector=nombreDirector;
        this.cantidadInvestigadores=0;
        //Se crea el vector y se inicializa en null, aunque Java lo haga automáticamente
        this.investigadores=new Investigador[50];
        for(int i=0; i<50; i++)
            this.investigadores[i]=null;
    }

    public String getNombreProyecto() {
        return nombreProyecto;
    }

    public void setNombreProyecto(String nombreProyecto) {
        this.nombreProyecto = nombreProyecto;
    }

    public int getCodigo() {
        return codigo;
    }

    public void setCodigo(int codigo) {
        this.codigo = codigo;
    }

    public String getNombreDirector() {
        return nombreDirector;
    }

    public void setNombreDirector(String nombreDirector) {
        this.nombreDirector = nombreDirector;
    }

    public int getCantidadInvestigadores() {
        return cantidadInvestigadores;
    }
    
    private Investigador devolverInvestigador(int posicion){
        return this.investigadores[posicion];
    }
    
    public boolean cupoInvestigadoresLleno(){
        return this.getCantidadInvestigadores()==50;
    }
    
    public void agregarInvestigador(Investigador unInvestigador){
        if(!this.cupoInvestigadoresLleno()){
            this.investigadores[this.cantidadInvestigadores]=unInvestigador;
            this.cantidadInvestigadores++;
        }
    }
    
    public double dineroTotalOtorgado(){
        double sumaMontos=0;
        for(int j=0; j<this.cantidadInvestigadores; j++)
            sumaMontos+=this.devolverInvestigador(j).devolverSubsidiosInvestigador();
        
        return sumaMontos;
    }
    
    public void otorgarTodos(String nombre){
        int indice=0;
        boolean encontrado=false;
        while(indice<this.getCantidadInvestigadores() && !encontrado){
            if(this.devolverInvestigador(indice).getNombre().equals(nombre))
                encontrado=true;
            else indice++;
        }
        if(encontrado)
            this.devolverInvestigador(indice).aprobarSubsidios();
    }
    
    /*Devolver un string con: nombre del proyecto, código, nombre del director, el
    total de dinero otorgado del proyecto y la siguiente información de cada
    investigador: nombre, categoría, especialidad, y el total de dinero de sus
    subsidios otorgados.
    */
    @Override
    public String toString(){
        String aux= this.getNombreProyecto() + " - " +
                    this.getCodigo() + 
                    " - Director: " + this.getNombreDirector() +
                    " - Dinero otorgado: " + this.dineroTotalOtorgado() +
                    ", Investigadores: \n";
        
        for(int h=0; h<this.getCantidadInvestigadores(); h++)
            aux+=this.devolverInvestigador(h).toString() + "\n";
        
        return aux;
    }
}
