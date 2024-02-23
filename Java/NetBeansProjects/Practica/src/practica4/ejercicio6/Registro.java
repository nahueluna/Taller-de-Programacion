/*
El Servicio Meteorológico Nacional necesita un sistema que permita registrar, para una
determinada estación meteorológica, la temperatura promedio mensual de N años
consecutivos a partir de un año A dado. Además, necesita dos versiones del sistema: una
que permita reportar el promedio histórico por años y otra que permita reportar el
promedio histórico por meses.
 */
package practica4.ejercicio6;

public class Registro {
    private Estacion estacion;
    private int años;
    private int añoInicial;
    private double [][] temperaturas;
    
    public Registro(Estacion estacion, int años, int añoInicial){
        this.estacion=estacion;
        this.años=años;
        this.añoInicial=añoInicial;
        this.temperaturas= new double[años][12];
        for(int i=0; i<this.años;i++)
            for(int j=0; j<12;j++)
                this.temperaturas[i][j]=999d;
    }

    public Estacion getEstacion() {
        return estacion;
    }

    public int getAños() {
        return años;
    }

    public int getAñoInicial() {
        return añoInicial;
    }
    
    //Registrar la temperatura de un mes y año recibidos por parámetro
    public void registrarTemperatura(int año, int mes, double temperatura){
        this.temperaturas[año - this.getAñoInicial()][mes-1]=temperatura;
    }
    //Obtener la temperatura de un mes y año recibidos por parámetro
    public double obtenerTemperatura(int año, int mes){
        return this.temperaturas[año - this.getAñoInicial()][mes-1];  //Se presuponen los rangos de año y mes en válidos
    }
    public double devolverPosicionTemperatura(int posAño, int posMes){
        return this.temperaturas[posAño][posMes];
    }
    //Devolver un String que concatena el mes y año en que se registró la mayor temperatura
    public String fechaMayorTemperatura(){
        int maxMes=0, maxAño=0;
        double maxTemp=-999d;
        String aux;
        for(int i=0; i<this.getAños(); i++){
            for(int j=0; j<12; j++){
                if(this.temperaturas[i][j] > maxTemp){
                    maxTemp=this.temperaturas[i][j];
                    maxAño=i;
                    maxMes=j;
                }
            }
        }
        aux = "La mayor temperatura se registro en el mes " + (maxMes+1) + " del año " + (maxAño+this.getAñoInicial()) + ".";
        return aux;
    }
    
    @Override
    public String toString(){
        String aux= this.getEstacion().getNombre() + 
                    " (" + this.getEstacion().getLatitud() +
                    " - " + this.getEstacion().getLongitud() + "):\n";
        
        return aux;
    }
}
