/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package repaso.ejercicio4;

public class CoroPorHileras extends Coro {
    private Corista[][] coristasHileras;
    private int dimlCoristas;
    private int filas;
    private int columnas;

    public CoroPorHileras(String nombre, Director director, int filas, int columnas) {
        super(nombre, director);
        this.coristasHileras = new Corista[filas][columnas];
        this.dimlCoristas=0;
        this.filas=filas;
        this.columnas=columnas;
    }

    public int getDimlCoristas() {
        return dimlCoristas;
    }

    public int getFilas() {
        return filas;
    }

    public int getColumnas() {
        return columnas;
    }
    
    private Corista devolverCorista(int fila, int columna){
        return this.coristasHileras[fila][columna];
    }
    
    @Override
    public boolean coroLleno(){
        return getDimlCoristas()==(getColumnas()*getFilas());
    }
    
    @Override
    public void agregarCorista(Corista corista){
        if(!coroLleno()){
            this.coristasHileras[getDimlCoristas()/getColumnas()][getDimlCoristas()%getColumnas()]=corista;
            this.dimlCoristas++;
        }
    }
    
    /*En el caso del coro por hileras, todos los miembros de una misma hilera
    tienen el mismo tono fundamental y además todos los primeros
    miembros de cada hilera están ordenados de mayor a menor en cuanto
    a tono fundamental.*/
    @Override
    public boolean coroBienFormado(){
        boolean estadoFormacion=true;
        int fila=0, columna;
        
        while(fila<getFilas() && estadoFormacion){
            columna=0;
            while((columna+1)<getColumnas() && estadoFormacion){
                if(devolverCorista(fila, columna).getTono()==devolverCorista(fila, columna+1).getTono())
                    columna++;
                else estadoFormacion=false;
            }
            fila++;
        }
        
        fila=0;
        while((fila+1)<getFilas() && estadoFormacion){
            if(devolverCorista(fila, 0).getTono()>=devolverCorista(fila+1, 0).getTono())
                fila++;
            else estadoFormacion=false;
        }
        
        return estadoFormacion;
    }
    
    @Override
    public String toString(){
        String aux= super.toString();
        
        for(int i=0; i<(getDimlCoristas()/getColumnas()); i++)
            for(int j=0; j<getColumnas(); j++)
                aux+= devolverCorista(i, j).toString() + "\n";
        
        //Recorro ultima fila (en caso de no estar completa) por separado
        for(int h=0; h<(getDimlCoristas()%getColumnas()); h++)
            aux+= devolverCorista((getDimlCoristas()/getColumnas()), h).toString() + "\n";
        
        return aux;
    }
}
