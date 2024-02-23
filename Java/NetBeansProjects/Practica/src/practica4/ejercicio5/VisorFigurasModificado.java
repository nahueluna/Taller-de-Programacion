package practica4.ejercicio5;

public class VisorFigurasModificado {
    private int guardadas;
    private int capacidadMaxima=5;
    private Figura [] vector;

    public VisorFigurasModificado(){
        this.guardadas=0;
        this.vector= new Figura[capacidadMaxima];
        for(int i=0; i<this.capacidadMaxima; i++)
            this.vector[i]= null;
    }

    public void guardar(Figura f){
        if(this.quedaEspacio()){
            this.vector[this.guardadas]= f;
            guardadas++;
        }
        
    }
    
    public boolean quedaEspacio(){
        return this.guardadas<this.capacidadMaxima;
    }

    public void mostrar(){
        for(int i=0;i<this.getGuardadas();i++)
            System.out.println(this.vector[i].toString());
    }
    
    public int getGuardadas() {
        return guardadas;
    }
}
