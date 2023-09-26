package medico


class CargoController {

    def list (){

    }

    def tablaCargos_ajax () {
        def cargos = Cargo.list().sort{it.descripcion}
        return [cargos: cargos]
    }

    def form_ajax () {
        def cargo

        if(params.id){
            cargo = Cargo.get(params.id)
            if (!cargo) {
                flash.clase = "alert-error"
                flash.message = "No se encontró el cargo"
                redirect(action: "list")
            } //no existe el objeto
        }else{
            cargo = new Cargo()
        }

        return[cargoInstance: cargo]
    }

    def saveCargo_ajax () {

        def cargo

        if(params.id){
            cargo = Cargo.get(params.id)
            if (!cargo) {
                flash.clase = "alert-error"
                flash.message = "No se encontró el cargo"
                redirect(action: "list")
            } //no existe el objeto
        }else{
            cargo = new Cargo()
        }

        cargo.properties = params

        if(!cargo.save(flush:true)){
            render("no_Error al guardar el cargo")
        }else{
            render("ok_Cargo guardado correctamente")
        }
    }

    def borrarCargo_ajax () {

        def cargo = Cargo.get(params.id)
        if (!cargo) {
            flash.clase = "alert-error"
            flash.message = "No se encontró el cargo"
            redirect(action: "list")
            //no existe el objeto
        }else{
            try {
                cargo.delete(flush:true)
                render "ok_Cargo borrado correctamente"
            }catch(e){
                println("error al borrar el cargo: " + e)
                render "no_Error al borrar el cargo"
            }
        }
    }

}
