package inventario


class CentroCostoController {

    def form_ajax(){

        def centro

        if(params.id){
            centro = CentroCosto.get(params.id)
        }else{
            centro = new CentroCosto()
        }

        return [centroCostoInstance: centro]
    }

    def list(){
        def centroCostoInstanceList = CentroCosto.list().sort{it.nombre}
        return [centroCostoInstanceList: centroCostoInstanceList]
    }

    def save_ajax(){
        def centro

        if(params.id){
            centro = CentroCosto.get(params.id)
        }else{
            centro = new CentroCosto()
        }

        centro.properties = params

        if(!centro.save(flush:true)){
            println("Error al guardar el centro de costos "  +  centro.errors)
            render "no_Error al guardar el centro de costos"
        }else{
            render "ok_Centro de costos guardado correctamente"
        }
    }

    def delete_ajax(){

        def centro = CentroCosto.get(params.id)

        if(centro){
            try {
                centro.delete(flush: true)
                render "ok_Borrado correctamente"
            }catch(e){
                println("Error al borrar el centro de costos" + centro.errors)
                render "no_Error al borrar el centro de costos"
            }
        }else{
            render "no_Error al borrar el centro de costos"
        }
    }

}
