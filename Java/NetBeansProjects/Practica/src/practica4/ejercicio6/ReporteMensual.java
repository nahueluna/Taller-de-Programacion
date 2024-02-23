/*
Version que permite reportar el promedio histórico por meses.
La versión del sistema que reporta por meses deberá calcular el promedio para
cada mes (el promedio del mes M se calcula con los datos de todos los años en ese
mes).
Ej: “La Plata (34,921 S - 57,955 O):
- Enero: 28,2 ºC;
- Febrero: 26,8 ºC;
- Marzo: 24.3 ºC
- "…"
 */
package practica4.ejercicio6;

public class ReporteMensual extends Registro {
    private double[] temperaturasMensual;
    private String[] nombreMeses;
    
    public ReporteMensual(Estacion estacion, int años, int añoInicial){
        super(estacion, años, añoInicial);
        this.setNombreMeses();
        this.temperaturasMensual= new double[12];
        for(int n=0; n<12; n++)
            this.temperaturasMensual[n]=999d;
    }
    
    private void setNombreMeses(){
        this.nombreMeses=new String[12];
        this.nombreMeses[0]="Enero";
        this.nombreMeses[1]="Febrero";
        this.nombreMeses[2]="Marzo";
        this.nombreMeses[3]="Abril";
        this.nombreMeses[4]="Mayo";
        this.nombreMeses[5]="Junio";
        this.nombreMeses[6]="Julio";
        this.nombreMeses[7]="Agosto";
        this.nombreMeses[8]="Septiembre";
        this.nombreMeses[9]="Octubre";
        this.nombreMeses[10]="Noviembre";
        this.nombreMeses[11]="Diciembre";
    }
    
    private void calcularPromedioMensual(){
        double sumaTemp;
            for(int i=0; i<12; i++){
            sumaTemp=0;
            for(int j=0; j<this.getAños(); j++)
                sumaTemp+=this.devolverPosicionTemperatura(j, i);
            this.temperaturasMensual[i]= (double)sumaTemp/this.getAños();
        }
    }
    
    @Override
    public String toString(){
        this.calcularPromedioMensual();
        String aux = super.toString();
        for(int i=0; i<this.getAños(); i++)
            aux+="- " + this.nombreMeses[i] +
                 ": " + this.temperaturasMensual[i] + "°C;\n";
        
        return aux;
    }
}
