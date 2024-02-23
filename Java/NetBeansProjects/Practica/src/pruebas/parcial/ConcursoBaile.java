/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pruebas.parcial;

public class ConcursoBaile {
    private Pareja[] parejas;
    private int cantidadParejas;
    private int dimlParejas;
    
    public ConcursoBaile(int cantidadParejas){
        this.parejas= new Pareja[cantidadParejas]; //Se considera inicializado en null
        this.cantidadParejas= cantidadParejas;
        this.dimlParejas=0;
    }

    public int getCantidadParejas() {
        return cantidadParejas;
    }

    public int getDimlParejas() {
        return dimlParejas;
    }
    
    private Pareja devolverPareja(int pos){
        return this.parejas[pos];
    }
    
    public void agregarPareja(Pareja unaPareja){
        this.parejas[getDimlParejas()] = unaPareja;
        this.dimlParejas++;
    }
    
    public Pareja devolverParejaMayorDiferencia(){
        Pareja parejaMax= devolverPareja(0);
        Pareja aux;
        for(int i=1; i<getDimlParejas(); i++){
            aux=devolverPareja(i);
            if(aux.devolverDiferenciaEdad()>parejaMax.devolverDiferenciaEdad())
                parejaMax=aux;
        }
        
        return parejaMax;
    }
}
