package practica4.ejercicio3;

public class Trabajador extends Persona {
    private String profesion;
    
    public Trabajador(String nombre, int DNI, int edad, String profesion){
        super(nombre, DNI, edad);
        this.setProfesion(profesion);
    }

    public String getProfesion() {
        return profesion;
    }

    public void setProfesion(String profesion) {
        this.profesion = profesion;
    }
    
    @Override
    public String toString(){
        String aux = super.toString() +
                     " Soy " + getProfesion();
        
        return aux;
    }
}
