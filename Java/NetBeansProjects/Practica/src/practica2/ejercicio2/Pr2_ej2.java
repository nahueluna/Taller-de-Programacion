/*
Utilizando la clase Persona. Realice un programa que almacene en un vector a lo sumo
15 personas. La información (nombre, DNI, edad) se debe generar aleatoriamente hasta
obtener edad 0. Luego de almacenar la información:
 - Informe la cantidad de personas mayores de 65 años.
 - Muestre la representación de la persona con menor DNI.
 */
package practica2.ejercicio2;

import PaqueteLectura.GeneradorAleatorio;
public class Pr2_ej2 {

    public static void main(String[] args) {
        final int cantPersonas=15;
        Persona[]personas=new Persona[cantPersonas];
        Persona personaMinimoDni=new Persona();
        int edadLeida, dimL=0, cantPersonasMayores=0;
        
        //Cargar personas
        GeneradorAleatorio.iniciar();
        edadLeida=GeneradorAleatorio.generarInt(100);
        while ((dimL<cantPersonas) && (edadLeida!=0)){
            personas[dimL]=new Persona();   //necesario crear cada posicion (reservar memoria)
            personas[dimL].setEdad(edadLeida);
            personas[dimL].setNombre(GeneradorAleatorio.generarString(7));
            personas[dimL].setDNI((GeneradorAleatorio.generarInt(50)+1)*1254631);
            
            dimL++; //cantidad de elementos cargados. La ultima posicion cargado es dimL-1
            edadLeida=GeneradorAleatorio.generarInt(100);
        }
        
        //Buscar persona con DNI minimo y cantidad de personas mayores a 65
        personaMinimoDni.setDNI(99999999);
        for(int i=0; i<dimL; i++){
            if(personas[i].getEdad()>65)
                cantPersonasMayores++;
            if(personas[i].getDNI()<personaMinimoDni.getDNI())
                personaMinimoDni=personas[i];
        }
        System.out.println("La cantidad de personas mayores a 65 años es de " + cantPersonasMayores);
        System.out.println("Persona con menor DNI: " + personaMinimoDni.toString());
            
    }
    
}
