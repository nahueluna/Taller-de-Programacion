/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package repaso.ejercicio3;

public abstract class Recital {
    private String banda;
    private String[] temas;
    private int cantidadTemas;
    private int dimlTemas;
    
    public Recital(String banda, int cantidadTemas){
        this.banda=banda;
        this.cantidadTemas=cantidadTemas;
        this.temas= new String[cantidadTemas];
        this.dimlTemas=0;
    }

    public String getBanda() {
        return banda;
    }

    public int getCantidadTemas() {
        return cantidadTemas;
    }

    public int getDimlTemas() {
        return dimlTemas;
    }
    //Se implementó de forma que accede a tema[0] recibiendo un 1
    public String devolverTema(int pos){
        return this.temas[pos-1];
    }
    
    public boolean listaTemaLlena(){
        return getDimlTemas()==getCantidadTemas();
    }
    
    public void agregarTema(String tema){
        if(!listaTemaLlena()){
            this.temas[getDimlTemas()]=tema;
            this.dimlTemas++;
        }
    }
    
    public String actuar(){
        String aux="";
        for(int i=0; i<getDimlTemas(); i++){
            aux+="Y ahora tocaremos... " + devolverTema(i+1) + "\n";
        }
        
        return aux;
    }
    
    public abstract double calcularCosto();
}
