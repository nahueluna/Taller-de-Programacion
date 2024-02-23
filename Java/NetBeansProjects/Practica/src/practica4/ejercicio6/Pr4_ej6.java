/*
Realice un programa principal que cree un Sistema con reporte anual para 3 años
consecutivos a partir del 2021, para la estación La Plata (latitud -34.921 y longitud -
57.955). Cargue todas las temperaturas (para todos los meses y años). Informe los
promedios anuales, y el mes y año en que se registró la mayor temperatura.
Luego cree un Sistema con informe mensual para 4 años a partir de 2020, para la
estación Mar del Plata (latitud -38.002 y longitud -57.556). Cargue todas las
temperaturas (para todos los meses y años). Informe los promedios mensuales, y el
mes y año en que se registró la mayor temperatura.

 */
package practica4.ejercicio6;

import PaqueteLectura.GeneradorAleatorio;

public class Pr4_ej6 {

    public static void main(String[] args) {
        Estacion e1 = new Estacion("La Plata",-34.921,-57.955);
        Estacion e2 = new Estacion("Mar del Plata", -38.002, -57.556);
        ReporteAnual regisAnual = new ReporteAnual(e1, 3, 2021);
        ReporteMensual regisMensual = new ReporteMensual(e2, 4, 2020);
        
        GeneradorAleatorio.iniciar();
        
        for(int i=0; i<3; i++)
            for(int j=0; j<12; j++){
                regisAnual.registrarTemperatura(2021+i, j+1, (GeneradorAleatorio.generarDouble(70)-30));
            }
        
        System.out.println(regisAnual.toString());
        System.out.println(regisAnual.fechaMayorTemperatura());
        
        System.out.println();
        
        for(int h=0; h<4; h++)
            for(int m=0; m<12; m++){
                regisMensual.registrarTemperatura(2020+h, m+1, (GeneradorAleatorio.generarDouble(70)-30));
            }
        
        System.out.println(regisMensual.toString());
        System.out.println(regisMensual.fechaMayorTemperatura());
    }
    
}
