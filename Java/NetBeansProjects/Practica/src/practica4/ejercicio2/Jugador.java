/*
 Los jugadores son empleados que se caracterizan por el número de partidos jugados y
el número de goles anotados.

Sueldo:  Para los jugadores: si el promedio de goles por partido es superior a 0,5 se adiciona un
plus de otro sueldo básico.
 */
package practica4.ejercicio2;

public class Jugador extends Empleado {
    private int partidos;
    private int goles;
    
    public Jugador(String nombre, double sueldo, int antiguedad, int partidos, int goles){
        super(nombre, sueldo, antiguedad);
        this.setPartidos(partidos);
        this.setGoles(goles);
    }

    public int getPartidos() {
        return partidos;
    }

    public void setPartidos(int partidos) {
        this.partidos = partidos;
    }

    public int getGoles() {
        return goles;
    }

    public void setGoles(int goles) {
        this.goles = goles;
    }
    
    private double calcularPlusSueldo(){
        double aux=0;
        if(this.calcularEfectividad()>0.5)
            aux=this.getSueldo();
        
        return aux;
    }
    
    @Override
    public double calcularEfectividad(){
        return (double)this.getGoles() / this.getPartidos();
    }
    
    @Override
    public double calcularSueldoACobrar(){
        double aux= super.calcularSueldoACobrar();
        
        return aux + this.calcularPlusSueldo();
    }
}
