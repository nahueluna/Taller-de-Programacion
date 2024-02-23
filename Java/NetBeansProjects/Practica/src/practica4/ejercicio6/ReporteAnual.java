/*
Version que permite reportar el promedio histórico por años
La versión del sistema que reporta por años deberá calcular el promedio para
cada año (el promedio del año X se calcula con los datos mensuales de ese año). 
 */
package practica4.ejercicio6;

public class ReporteAnual extends Registro{
    private double temperaturasAnual[];
    
    public ReporteAnual(Estacion estacion, int años, int añoInicial){
        super(estacion, años, añoInicial);
        this.temperaturasAnual = new double[años];
        for(int h=0; h<this.getAños(); h++)
            this.temperaturasAnual[h]=999d;
    }
    
    private void calcularPromedioAnual(){
        double sumaTemp;
        for(int i=0; i<this.getAños(); i++){
            sumaTemp=0;
            for(int j=0; j<12; j++)
                sumaTemp+=this.devolverPosicionTemperatura(i, j);
            this.temperaturasAnual[i]= (double)sumaTemp/12;
        }
    }
    
    @Override
    public String toString(){
        this.calcularPromedioAnual();
        String aux = super.toString();
        for(int i=0; i<this.getAños(); i++)
            aux+="- Año " + (this.getAñoInicial() + i) +
                 ": " + this.temperaturasAnual[i] + "°C;\n";
        
        return aux;
    }
}
