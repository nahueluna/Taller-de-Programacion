/*
 Los entrenadores son empleados que se caracterizan por la cantidad de campeonatos
ganados

Sueldo:  Para los entrenadores: se adiciona un plus por campeonatos ganados (5000$ si ha
ganado entre 1 y 4 campeonatos; $30.000 si ha ganado entre 5 y 10 campeonatos;
50.000$ si ha ganado más de 10 campeonatos). 
 */
package practica4.ejercicio2;

public class Entrenador extends Empleado {
    private int campeonatosGanados;
    
    public Entrenador(String nombre, double sueldo, int antiguedad, int campeonatos){
        super(nombre, sueldo, antiguedad);
        this.setCampeonatosGanados(campeonatos);
    }

    public int getCampeonatosGanados() {
        return campeonatosGanados;
    }

    public void setCampeonatosGanados(int campeonatosGanados) {
        this.campeonatosGanados = campeonatosGanados;
    }
    
    private double calcularPlusSueldo(){
        double aux=0;
        if(this.getCampeonatosGanados()>=1 && this.getCampeonatosGanados()<=4)
            aux=5000;
        else if(this.getCampeonatosGanados()>=5 && this.getCampeonatosGanados()<=10)
            aux=30000;
        else if(this.getCampeonatosGanados()>10)
            aux=50000;
        
        return aux;
    } 
    
    @Override
    public double calcularEfectividad(){
        return (double)this.getCampeonatosGanados() / this.getAntiguedad();
    }
    
    @Override
    public double calcularSueldoACobrar(){
        double aux= super.calcularSueldoACobrar();
        
        return aux + this.calcularPlusSueldo();
    }
}
