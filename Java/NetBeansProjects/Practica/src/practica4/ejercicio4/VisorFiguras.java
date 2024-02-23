/*
- Un objeto visor de figuras se encarga de mostrar en consola cualquier figura que reciba
y también mantiene cuántas figuras mostró
 */
package practica4.ejercicio4;

public class VisorFiguras {
    private int mostradas;

    public VisorFiguras(){
        mostradas=0;
    }
    public void mostrar(Figura f){
        System.out.println(f.toString());
        mostradas++;
    }
    public int getMostradas() {
        return mostradas;
    }

}
