/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package repaso.ejercicio4;

public class CoroSemicircular extends Coro{
    private Corista[] coristasSC;
    private int dimlCoristas;
    private int cantidadCoristas;

    public CoroSemicircular(String nombre, Director director, int cantidadCoristas) {
        super(nombre, director);
        this.coristasSC= new Corista[cantidadCoristas];
        this.cantidadCoristas=cantidadCoristas;
        this.dimlCoristas=0;
    }

    public int getDimlCoristas() {
        return dimlCoristas;
    }

    public int getCantidadCoristas() {
        return cantidadCoristas;
    }
    
    private Corista devolverCorista(int pos){
        return this.coristasSC[pos];
    }
    
    @Override
    public boolean coroLleno(){
        return getDimlCoristas()==getCantidadCoristas();
    }
    
    @Override
    public void agregarCorista(Corista corista){
        if(!coroLleno()){
            this.coristasSC[getDimlCoristas()]=corista;
            this.dimlCoristas++;
        }
    }
    
    /*En el caso del coro semicircular, de izquierda a derecha los coristas
    están ordenados de mayor a menor en cuanto a tono fundamental.*/
    @Override
    public boolean coroBienFormado(){
        boolean estadoFormacion=true;
        int indice=0;
        while((indice+1)<getCantidadCoristas() && estadoFormacion){
            if(devolverCorista(indice).getTono()>=devolverCorista(indice+1).getTono())
                indice++;
            else estadoFormacion=false;
        }
        
        return estadoFormacion;
    }
    
    @Override
    public String toString(){
        String aux= super.toString();
        
        for(int i=0; i<getDimlCoristas(); i++)
            aux+= devolverCorista(i).toString() + "\n";
        
        return aux;
    }
}
