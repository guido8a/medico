package medico

import seguridad.Empresa

class ProductoController {

    def arbol(){
        def hh = Grupo.count()
        def empresa = Empresa.get(params.id)
        return [hh: hh, empresa: empresa]
    }

    def loadTreePart() {
        render(makeBasicTree(params))
    }

    def makeBasicTree(params) {
//        println "makeTreeNode.. $params"
        def id = params.id
        def tipo = ""
        def liId = ""
        def ico = ""

        if(id.contains("_")) {
            id = params.id.split("_")[1]
            tipo = params.id.split("_")[0]
        }

        if (!params.order) {
            params.order = "asc"
        }

        String tree = "", clase = "", rel = ""
        def padre
        def hijos = []

        if (id == "#") {
            //root
            def hh = Grupo.list()
            if (hh) {
                clase = "hasChildren jstree-closed"
            }
            tree = "<li id='root' class='root ${clase}' data-jstree='{\"type\":\"root\"}' data-level='0' >" +
                    "<a href='#' class='label_arbol'>${'Arbol de productos'}</a>" +
                    "</li>"
        } else {
            if(id == 'root'){
                hijos = Grupo.list()
                def data = ""
                ico = ", \"icon\":\"fa fa-copyright text-info\""
                hijos.each { hijo ->
                    clase = Subgrupo.findAllByGrupo(hijo) ? "jstree-closed hasChildren" : "jstree-closed"
                    tree += "<li id='gp_" + hijo.id + "' class='" + clase + "' ${data} data-tipo='${Grupo.get(hijo.id)?.id}' data-jstree='{\"type\":\"${"principal"}\" ${ico}}' >"
                    tree += "<a href='#' class='label_arbol'>" + hijo?.descripcion + "</a>"
                    tree += "</li>"
                }
            }else{
                switch(tipo) {
                    case "gp":
                        hijos = Subgrupo.findAllByGrupo(Grupo.get(id), [sort: 'id'])
                        liId = "sg_"
                        ico = ", \"icon\":\"fa fa-parking text-success\""
                        hijos.each { h ->
                            clase = Producto.findBySubgrupo(h) ? "jstree-closed hasChildren" : ""
                            tree += "<li id='" + liId + h.id + "' class='" + clase + "' data-tipo='${Grupo.get(params.tipo)?.id}' data-jstree='{\"type\":\"${"subgrupo"}\" ${ico}}'>"
                            tree += "<a href='#' class='label_arbol'>"  +  "<strong>" + " "  + "</strong>" +  h.descripcion + "</a>"
                            tree += "</li>"
                        }
                        break
                    case "sg":
                        hijos = Producto.findAllBySubgrupo(Subgrupo.get(id), [sort: 'numero'])
                        liId = "dp_"
                        ico = ", \"icon\":\"fa fa-registered text-warning\""
                        hijos.each { h ->
//                            clase = Producto.get(h?.id)? "jstree-closed hasChildren" : ""
                            clase = ""
                            tree += "<li id='" + liId + h.id + "' class='" + clase + "'  data-tipo='${Grupo.get(params.tipo)?.id}' data-jstree='{\"type\":\"${"producto"}\" ${ico}}'>"
                                tree += "<a href='#' class='label_arbol'>" +  "<strong>"  + "" + "</strong>"  + h.texto + "</a>"
                            tree += "</li>"
                        }
                        break
                }
            }
        }
        return tree
    }

    def formGrupo_ajax(){
        def grupo

        if(params.id){
            grupo = Grupo.get(params.id)
        }else{
            grupo = new Grupo()
        }

        return [grupo: grupo]
    }

    def saveGrupo_ajax(){

        def grupo

        if(params.id){
            grupo = Grupo.get(params.id)
        }else{
            grupo = new Grupo()
        }

        grupo.properties = params

        if(!grupo.save(flush:true)){
            println("error al guardar el grupo " + grupo.errors)
            render "no_Error al guardar el grupo"
        }else{
            render "ok_Grupo guardado correctamente"
        }

    }

    def formSubgrupo_ajax(){

        def grupo = Grupo.get(params.padre)
        def empresa = Empresa.get(params.empresa)
        def subgrupo

        if(params.id){
            subgrupo = Subgrupo.get(params.id)
        }else{
            subgrupo = new Subgrupo()
        }

        return [subgrupo: subgrupo, grupo: grupo, empresa: empresa]
    }

    def saveSubgrupo_ajax(){

        def subgrupo

        if(params.id){
            subgrupo = Subgrupo.get(params.id)
        }else{
            subgrupo = new Subgrupo()
        }

        subgrupo.properties = params

        if(!subgrupo.save(flush:true)){
            println("error al guardar el subgrupo " + subgrupo.errors)
            render "no_Error al guardar el subgrupo"
        }else{
            render "ok_Subgrupo guardado correctamente"
        }
    }

    def formProducto_ajax(){

        def subgrupo = Subgrupo.get(params.padre)
        def empresa = Empresa.get(params.empresa)
        def producto

        if(params.id){
            producto = Producto.get(params.id)
        }else{
            producto = new Producto()
        }

        return [subgrupo: subgrupo, producto: producto, empresa: empresa]
    }

    def saveProducto_ajax(){

        def producto

        if(params.id){
            producto = Producto.get(params.id)
        }else{
            producto = new Producto()
            producto.fecha = new Date()
        }

        producto.properties = params
        producto.fechaModificacion = new Date()

        if(!producto.save(flush:true)){
            println("error al guardar el producto " + producto.errors)
            render "no_Error al guardar el producto"
        }else{
            render "ok_Producto guardado correctamente"
        }
    }

    def borrarProducto_ajax(){

        def producto = Producto.get(params.id)

        try{
            producto.delete(flush: true)
            render "ok"
        }catch(e){
            println("error al borrar el producto " + producto.errors)
            render "no"
        }
    }


    def borrarSubgrupo_ajax(){

        def subgrupo = Subgrupo.get(params.id)

        try{
            subgrupo.delete(flush: true)
            render "ok"
        }catch(e){
            println("error al borrar el subgrupo " + subgrupo.errors)
            render "no"
        }
    }
    def borrarGrupo_ajax(){

        def grupo = Grupo.get(params.id)

        try{
            grupo.delete(flush: true)
            render "ok"
        }catch(e){
            println("error al borrar el grupo " + grupo.errors)
            render "no"
        }
    }

}

