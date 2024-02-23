/*
De cada subsidio se conoce: el monto pedido, el motivo y si fue otorgado o no
 */
package repaso.ejercicio1;

public class Subsidio {
    private double monto;
    private String motivo;
    private boolean estado;
    
    public Subsidio(double monto, String motivo){
        this.monto=monto;
        this.motivo=motivo;
        this.estado=false;
    }

    public double getMonto() {
        return monto;
    }

    public void setMonto(double monto) {
        this.monto = monto;
    }

    public String getMotivo() {
        return motivo;
    }

    public void setMotivo(String motivo) {
        this.motivo = motivo;
    }

    public void setEstado(boolean estado) {
        this.estado = estado;
    }

    public boolean isEstado() {
        return estado;
    }
}
