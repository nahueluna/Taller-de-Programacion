/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package repaso.ejercicio3;

public class Fecha {
    private String ciudad;
    private int dia;

    public Fecha(String ciudad, int dia) {
        this.ciudad = ciudad;
        this.dia = dia;
    }

    public String getCiudad() {
        return ciudad;
    }

    public int getDia() {
        return dia;
    }
}
