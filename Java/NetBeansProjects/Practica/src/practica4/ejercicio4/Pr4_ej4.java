package practica4.ejercicio4;

public class Pr4_ej4 {

    public static void main(String[] args) {
        VisorFiguras visor = new VisorFiguras();

        Cuadrado c1 = new Cuadrado(10,"Violeta","Rosa");
        Rectangulo r= new Rectangulo(20,10,"Azul","Celeste");
        Cuadrado c2= new Cuadrado(30,"Rojo","Naranja");

        visor.mostrar(c1);
        visor.mostrar(r);
        visor.mostrar(c2);

        System.out.println(visor.getMostradas());
    }
    
}
/* 
La instancia de clase VisorFiguras tiene un método el cual recibe un parámetro de clase Figura e imprime el toString
del mismo, haciendo llamado a dicho mensaje dentro del método de VisorFiguras. Luego, incrementa en uno la variable de 
instancia de esta clase llamada "mostradas" (inicializada en 0 al momento de la construcción) que opera como contador de las
instancias de Figura recibidas. 
Así, se invoca 3 veces el método mostrar de la instancia visor, lo que envía un mensaje toString a cada instancia de Figura 
pasada como parámetro y contabiliza la cantidad de objetos de esa clase.
Finalmente, imprime el retorno del método getMostradas, que devuelve la cantidad de instancias de Figura que fueron 
recibidas por la instancia de VisorFiguras de nombre visor.
*/