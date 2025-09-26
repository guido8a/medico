package inventario

import seguridad.Empresa

class BodegaController {

    def list(){
        def bodegas = Bodega.list().sort{it.descripcion}
        return[bodegas: bodegas]
    }

    def form_ajax(){

        def bodega
        def empresa = Empresa.get(session.empresa.id)

        if(params.id){
            bodega = Bodega.get(params.id)
        }else{
            bodega = new Bodega()
        }

        return[bodega:bodega, empresa: empresa]
    }

    def save_ajax(){

        def bodega

        if(params.id){
            bodega = Bodega.get(params.id)
        }else{
            bodega = new Bodega()
        }

        bodega.properties = params

        if(!bodega.save(flush:true)){
            println("error al guardar bodega " + bodega.errors)
            render "no"
        }else{
            render "ok"
        }
    }

    def delete_ajax(){

        def bodega = Bodega.get(params.id)

        try{
            bodega.delete(flush:true)
            render "ok"
        }catch(e){
            println("error al borrar bodega " + bodega.errors)
            render "no"
        }
    }
}
