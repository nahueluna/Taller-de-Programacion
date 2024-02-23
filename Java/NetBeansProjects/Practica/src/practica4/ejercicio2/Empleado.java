/*
Queremos representar a los empleados de un club: jugadores y entrenadores.
 Cualquier empleado se caracteriza por su nombre, sueldo básico y antigüedad.

Cualquier empleado debe responder al mensaje calcularEfectividad. La efectividad
del entrenador es el promedio de campeonatos ganados por año de antigüedad, mientras
que la del jugador es el promedio de goles por partido.

Cualquier empleado debe responder al mensaje calcularSueldoACobrar. El sueldo a
cobrar es el sueldo básico más un 10% del básico por cada año de antigüedad y además:
 Para los jugadores: si el promedio de goles por partido es superior a 0,5 se adiciona un
plus de otro sueldo básico.
 Para los entrenadores: se adiciona un plus por campeonatos ganados (5000$ si ha
ganado entre 1 y 4 campeonatos; $30.000 si ha ganado entre 5 y 10 campeonatos;
50.000$ si ha ganado más de 10 campeonatos). 
 */
package practica4.ejercicio2;

public abstract class Empleado {
    private String nombre;
    private double sueldo;
    private int antiguedad;
    
    public Empleado(String nombre, double sueldo, int antiguedad){
        this.setNombre(nombre);
        this.setSueldo(sueldo);
        this.setAntiguedad(antiguedad);
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public double getSueldo() {
        return sueldo;
    }

    public void setSueldo(double sueldo) {
        this.sueldo = sueldo;
    }

    public int getAntiguedad() {
        return antiguedad;
    }

    public void setAntiguedad(int antiguedad) {
        this.antiguedad = antiguedad;
    }
    
    /*toString está implementado en la superclase porque informa lo mismo para ambas subclases. La diferencia
    es que cada instancia de subclase accede a sus propios métodos (distintos entre si) al entrar en el toString*/
    @Override
    public String toString(){
        String aux = "Nombre: " + this.getNombre() +
                     " - Sueldo a cobrar:  " + this.calcularSueldoACobrar()+
                     " - Efectividad: " + this.calcularEfectividad();
        
        return aux;
    }
    
    public double calcularSueldoACobrar(){
        return this.getSueldo() + ((0.1 * this.getSueldo()) * this.getAntiguedad());
    }
    
    public abstract double calcularEfectividad();
}
