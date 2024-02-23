/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package repaso.ejercicio3;

public class EventoOcasional extends Recital {
    private String motivo;
    private String contratante;
    private int dia;
    
    public EventoOcasional(String banda, int cantidadTemas, String motivo, String contratante, int dia){
        super(banda, cantidadTemas);
        this.motivo=motivo;
        this.contratante=contratante;
        this.dia=dia;
    }

    public String getMotivo() {
        return motivo;
    }

    public String getContratante() {
        return contratante;
    }

    public int getDia() {
        return dia;
    }
    
    @Override
    public String actuar(){
        String aux;
        
        switch (getMotivo()) {
            case "a beneficio":
                aux="Recuerden colaborar con " + getContratante() + "\n";
                break;
            case "show de TV":
                aux="Saludos amigos televidentes \n";
                break;
            default:
                aux="Un feliz cumpleaños para " + getContratante() + "\n";
                break;
        }
        
        aux+=super.actuar();
        
        return aux;
    }
    
    //. Si es un evento ocasional devuelve 0 si es a beneficio, 50000 si es un show de TV y 150000 si es privado
    @Override
    public double calcularCosto(){
        double aux;
        
        switch (getMotivo()){
            case "a beneficio":
                aux=0;
                break;
            case "show de TV":
                aux=50000;
                break;
            default:
                aux=150000;
                break;
        }
        
        return aux;
    }
}
