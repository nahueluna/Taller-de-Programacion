/*
Queremos un sistema para gestionar estacionamientos. Un estacionamiento conoce su
nombre, dirección, hora de apertura, hora de cierre, y almacena para cada número de piso
(1..N) y número de plaza (1..M), el auto que ocupa dicho lugar.

Implemente constructores. En particular, para el estacionamiento:
- Un constructor debe recibir nombre y dirección, e iniciar el estacionamiento
con hora de apertura “8:00”, hora de cierre “21:00”, y para 5 pisos y 10 plazas
por piso. El estacionamiento inicialmente no tiene autos.
- Otro constructor debe recibir nombre, dirección, hora de apertura, hora de
cierre, el número de pisos (N) y el número de plazas por piso (M) e iniciar el
estacionamiento con los datos recibidos y sin autos. 
 */
package repaso.ejercicio2;

public class Estacionamiento {
    private String nombre;
    private String direccion;
    private String horaApertura;
    private String horaCierre;
    private Auto[][] autosEdificio;
    private int cantidadPisos;
    private int cantidadPlazasPorPiso;
    
    public Estacionamiento(String nombre, String direccion){
        this.nombre=nombre;
        this.direccion=direccion;
        this.horaApertura="8:00";
        this.horaCierre="21:00";
        this.cantidadPisos=5;
        this.cantidadPlazasPorPiso=10;
        this.autosEdificio=new Auto[this.cantidadPisos][this.cantidadPlazasPorPiso];
        for(int i=0; i<this.getCantidadPisos(); i++)
            for(int j=0; j<this.getCantidadPlazasPorPiso(); j++)
                this.autosEdificio=null;
    }
    
    public Estacionamiento(String nombre, String direccion, String horaApertura, String horaCierre, int pisos, int plazas){
        this.nombre=nombre;
        this.direccion=direccion;
        this.horaApertura=horaApertura;
        this.horaCierre=horaCierre;
        this.cantidadPisos=pisos;
        this.cantidadPlazasPorPiso=plazas;
        this.autosEdificio=new Auto[this.cantidadPisos][this.cantidadPlazasPorPiso];
        for(int i=0; i<this.getCantidadPisos(); i++)
            for(int j=0; j<this.getCantidadPlazasPorPiso(); j++)
                this.autosEdificio[i][j]=null;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public String getHoraApertura() {
        return horaApertura;
    }

    public void setHoraApertura(String horaApertura) {
        this.horaApertura = horaApertura;
    }

    public String getHoraCierre() {
        return horaCierre;
    }

    public void setHoraCierre(String horaCierre) {
        this.horaCierre = horaCierre;
    }

    public int getCantidadPisos() {
        return cantidadPisos;
    }

    public int getCantidadPlazasPorPiso() {
        return cantidadPlazasPorPiso;
    }
    
    private Auto devolverAuto(int posPiso, int posPlaza){
        return this.autosEdificio[posPiso][posPlaza];
    }
    
    /*Dado un auto A, un número de piso X y un número de plaza Y, registrar al auto
    en el estacionamiento en el lugar X,Y. Suponga que X, Y son válidos (es decir,
    están en rango 1..N y 1..M respectivamente) y que el lugar está desocupado.*/
    public void registrarAuto(Auto unAuto, int posPiso, int posPlaza){
        this.autosEdificio[posPiso-1][posPlaza-1]=unAuto;
    }
    
    /*Dada una patente, obtener un String que contenga el número de piso y plaza
    donde está dicho auto en el estacionamiento. En caso de no encontrarse,
    retornar el mensaje “Auto Inexistente”.*/
    public String devolverPosicionAuto(String unaPatente){
        String aux;
        int indicePiso=0, indicePlaza=0;    //inicializo porque sino no compila
        boolean encontrado=false;
        
        while(indicePiso<this.getCantidadPisos() && !encontrado){
            indicePlaza=0;
            while(indicePlaza<this.getCantidadPlazasPorPiso() && !encontrado){
                if(this.devolverAuto(indicePiso, indicePlaza)!=null)
                    if(this.devolverAuto(indicePiso, indicePlaza).getPatente().equals(unaPatente))
                        encontrado=true;
                if(!encontrado) 
                    indicePlaza++;
            }
            if(!encontrado)
                indicePiso++;
        }
        
        if(encontrado)
            aux="El auto de patente " + unaPatente + " está en el piso " + (indicePiso+1) + " y plaza " + (indicePlaza+1);
        else
            aux="Auto Inexistente";
        
        return aux;
    }
    
    /*Obtener un String con la representación del estacionamiento. Ejemplo: “Piso 1
    Plaza 1: libre Piso 1 Plaza 2: representación del auto …
    Piso 2 Plaza 1: libre … etc”*/
    @Override
    public String toString(){
        String aux="";
        for(int i=0; i<this.getCantidadPisos(); i++){
            for(int j=0; j<this.getCantidadPlazasPorPiso(); j++){
                aux+="Piso " + (i+1) + ", Plaza " + (j+1) + ": ";
                if(this.devolverAuto(i, j)==null)
                    aux+="Libre\n";
                else
                    aux+=this.devolverAuto(i, j).toString() + "\n";
            }
        }
        
        return aux;
    }
    
    //Dado un número de plaza Y, obtener la cantidad de autos ubicados en dicha plaza (teniendo en cuenta todos los pisos).
    public int cantidadDeAutosEnPlaza(int posPlaza){
        int cantidadAutos=0;
        for(int h=0; h<this.getCantidadPisos(); h++)
            if(this.devolverAuto(h, posPlaza-1)!=null)
                cantidadAutos++;
        
        return cantidadAutos;
    }
}
