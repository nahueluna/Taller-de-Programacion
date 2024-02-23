/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package repaso.ejercicio3;

public class Gira extends Recital {
    private String nombre;
    private Fecha[] fechas;
    private int indiceFechaActual;
    private int cantidadFechas;
    private int dimlFechas;

    public Gira(String nombre, int cantidadFechas, String banda, int cantidadTemas) {
        super(banda, cantidadTemas);
        this.nombre = nombre;
        this.cantidadFechas = cantidadFechas;
        this.dimlFechas = 0;
        this.fechas = new Fecha[cantidadTemas];
        this.indiceFechaActual = 0;
    }

    public String getNombre() {
        return nombre;
    }

    public int getIndiceFechaActual() {
        return indiceFechaActual;
    }

    public int getCantidadFechas() {
        return cantidadFechas;
    }

    public int getDimlFechas() {
        return dimlFechas;
    }
    
    public boolean fechasLlenas(){
        return getDimlFechas()==getCantidadFechas();
    }
    
    private Fecha devolverFecha(int pos){
        return this.fechas[pos];
    }
    
    public void agregarFecha(Fecha fecha){
        if(!fechasLlenas()){
            this.fechas[getDimlFechas()]=fecha;
            this.dimlFechas++;
        }
    }
    
    @Override
    public String actuar(){
        String aux="Buenas noches " + devolverFecha(getIndiceFechaActual()).getCiudad() + "\n";
        aux+=super.actuar();
        this.indiceFechaActual++;
        
        return aux;
    }
    
    @Override
    public double calcularCosto(){
        return 30000*getCantidadFechas();
    }
}
