/*
Escriba un programa que instancie un proyecto con tres investigadores. Agregue dos
subsidios a cada investigador y otorgue los subsidios de uno de ellos. Luego imprima
todos los datos del proyecto en pantalla.
 */
package repaso.ejercicio1;

import PaqueteLectura.Lector;

public class repaso_ej1 {

    public static void main(String[] args) {
        Subsidio s1,s2;
        Investigador[] investigadores=new Investigador[3];
        Proyecto p1;
        
        System.out.println("Ingrese un nombre de proyecto, codigo y nombre de director: ");
        p1=new Proyecto(Lector.leerString(), Lector.leerInt(), Lector.leerString());
        
        for(int i=0; i<3; i++){
            System.out.println("Ingrese nombre, categoria y especialidad del investigador: ");
            investigadores[i]=new Investigador(Lector.leerString(), Lector.leerInt(), Lector.leerString());
            
            System.out.println("Ingrese monto y motivo del subsidio: ");
            s1=new Subsidio(Lector.leerDouble(), Lector.leerString());
            s2=new Subsidio(Lector.leerDouble(), Lector.leerString());
            
            investigadores[i].agregarSubsidio(s1);
            investigadores[i].agregarSubsidio(s2);
            
            p1.agregarInvestigador(investigadores[i]);
        }
        
        System.out.println("Ingrese el nombre del investigador que desea otorgarle los subsidios: ");
        p1.otorgarTodos(Lector.leerString());
        
        System.out.println();
        System.out.println(p1.toString());
    }
    
}
