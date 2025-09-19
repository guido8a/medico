package medico

import seguridad.Empresa

class ProductoController {

    def arbol(){
        //<!--grpo--><!--sbgr -> Grupo--><!--dprt -> Subgrupo--><!--item-->
        //materiales = 1
        //mano de obra = 2
        //equipo = 3
        def hh = Grupo.count()
        return [hh: hh]
    }

    def loadTreePart() {
        render(makeBasicTree(params))
    }

//    String makeBasicTree_old(params) {
////        println "makeBasicTree: $params"
//        def empr = Empresa.get(session.empresa.id)
//        def ids = params.id
//        def id
//        def tp
//        def tipo = params.tipo
//        def precios = params.precios
//        def all = params.all ? params.all.toBoolean() : false
//        def ignore = params.ignore ? params.ignore.toBoolean() : false
//        String tree = "", clase = ""
//
//        def hijos = []
//
////        println "ids: $ids"
//        if (ids == "#") {
//            //root
//            def gr = params.tipo.split('_')[1].toInteger()
//            def grupo = ['Artículos de Inventario']
//            clase = "hasChildren jstree-closed"
//            tree = "<li id='root' class='root ${clase}' data-jstree='{\"type\":\"root\"}' level='0' ><a href='#' class='label_arbol'>${grupo[gr-1]}</a></li>"
//        } else if (ids == "root") {
//            id = params.tipo.split('_')[1]
//            tipo = params.tipo.split('_')[0]
//        } else {
//            id = ids.split('_')[1]
//            tp = ids.split('_')[0]
//        }
//
//        if (tree == "" && id) {
////            switch (tipo) {
////                case "grupo_manoObra":
////                    hijos = DepartamentoItem.findAllBySubgrupo(SubgrupoItems.get(id), [sort: 'codigo'])
////                    break;
////                case "grupo":
////                    hijos = SubgrupoItems.findAllByGrupoAndEmpresa(Grupo.get(id), empr, [sort: 'codigo'])
////                    break;
////                case "subgrupo_manoObra":
////                    hijos = Item.findAllByDepartamento(DepartamentoItem.get(id), [sort: 'codigo'])
////                    break;
////                case "subgrupo_material":
////                case "subgrupo_equipo":
////                    hijos = DepartamentoItem.findAllBySubgrupo(SubgrupoItems.get(id), [sort: 'codigo'])
////                    break;
////                case "departamento_manoObra":
////                case "departamento_material":
////                case "departamento_equipo":
////                    hijos = Item.findAllByDepartamento(DepartamentoItem.get(id), [sort: 'codigo'])
////                    break;
////                case "item_manoObra":
////                case "item_material":
////                case "item_equipo":
////                    def tipoLista = Item.get(id).tipoLista
////                    if (precios) {
////                        if (ignore) {
////                            hijos = ["Todos"]
////                        } else {
////                            hijos = []
////                            if (tipoLista) {
////                                hijos = Lugar.findAllByTipoLista(tipoLista)
////                            }
////                        }
////                    }
////                    break;
////            }
//
//
//            hijos = DepartamentoItem.findAllBySubgrupo(SubgrupoItems.get(id), [sort: 'codigo'])
//
//            String rel = "", extra = ""
//            tree += "<ul>"
//            hijos.each { hijo ->
//                def hijosH, desc, liId
//                switch (tipo) {
//                    case "grupo_manoObra":
//                        hijosH = Item.findAllByDepartamento(hijo, [sort: 'codigo'])
//                        desc = hijo.codigo.toString().padLeft(3, '0') + " " + hijo.descripcion
//                        def parts = tipo.split("_")
//                        rel = "departamento_" + parts[1]
//                        liId = "dp" + "_" + hijo.id
//                        break;
//                    case "grupo_material":
//                    case "grupo":
//                        hijosH = DepartamentoItem.findAllBySubgrupo(hijo, [sort: 'codigo'])
//                        desc = hijo.codigo.toString().padLeft(3, '0') + " " + hijo.descripcion
//                        def parts = tipo.split("_")
//                        liId = "sg" + "_" + hijo.id
//                        break;
//                    case "subgrupo_manoObra":
//                        break;
//                    case "subgrupo_material":
//                    case "subgrupo_equipo":
//                        def item
//                        try {
//                            item = Item.list()
//                        } catch (e) {
//                            println "error: $e"
//                        }
//                        hijosH = Item.findAllByDepartamento(hijo, [sort: 'codigo'])
//                        desc = hijo.subgrupo.codigo.toString().padLeft(3, '0') + '.' + hijo.codigo.toString().padLeft(3, '0') + " " + hijo.descripcion
//                        def parts = tipo.split("_")
//                        rel = "departamento_" + parts[1]
//                        liId = "dp" + "_" + hijo.id
//                        break;
//                    case "departamento_manoObra":
//                        hijosH = []
//                        def tipoLista = hijo.tipoLista
//                        if (precios) {
//                            if (ignore) {
//                                hijosH = ["Todos"]
//                            } else {
//                                if (tipoLista) {
//                                    hijosH = Lugar.findAllByTipoLista(tipoLista)
//                                }
//                            }
//                        }
//                        desc = hijo.codigo + " " + hijo.nombre
//                        def parts = tipo.split("_")
//                        rel = "item_" + parts[1]
//                        liId = "it" + "_" + hijo.id
//                        break;
//                    case "departamento_material":
//                    case "departamento_equipo":
//                        hijosH = []
//                        def tipoLista // no hay
//                        if (precios) {
//                            if (ignore) {
//                                hijosH = ["Todos"]
//                            } else {
//                                if (tipoLista) {
//                                    hijosH = Lugar.findAllByTipoLista(tipoLista)
//                                }
//                            }
//                        }
//                        desc = hijo.codigo + " " + hijo.nombre
//                        def parts = tipo.split("_")
//                        rel = "item_" + parts[1]
//                        liId = "it" + "_" + hijo.id
//                        break;
//                    case "item_manoObra":
//                        hijosH = []
//                        if (precios) {
//                            hijosH = []
//                            if (ignore) {
//                                desc = "mo4  " + "Todos los lugares"
//                                rel = "lugar_all"
//                                liId = "lg_" + id + "_all"
//                            } else {
//                                if (all) {
//                                    desc = hijo.descripcion + " (" + hijo.tipo + ")"
//                                } else {
//                                    desc = hijo.descripcion
//                                }
//                                rel = "lugar"
//                                liId = "lg_" + id + "_" + hijo.id
//
//                                def obras = Obra.countByLugar(hijo)
//                                extra = "data-obras='${obras}'"
//                            }
//                        }
//                        break;
//                }
//
//                if (!hijosH) {
//                    hijosH = []
//                }
//                clase = (hijosH?.size() > 0) ? "jstree-closed hasChildren" : ""
//
//                tree += "<li id='" + liId + "' class='" + clase + "' rel='" + rel + "' " + extra + " data-jstree='{\"type\":\"${tipo}\"}' >"
//                tree += "<a href='#' class='label_arbol'>" + desc + "</a>"
//                tree += "</li>"
//            }
//        }
//        tree += "</ul>"
//        return tree
//    }


    def makeBasicTree(params) {
        println "makeTreeNode.. $params"
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
                ico = ", \"icon\":\"fa fa-parking text-success\""
                hijos.each { hijo ->
                    clase = Subgrupo.findAllByGrupo(hijo) ? "jstree-closed hasChildren" : "jstree-closed"
//                    tree += "<li id='gp_" + hijo.id + "' class='" + clase + "' ${data} data-tipo='${Grupo.get(params.tipo)?.id}' data-jstree='{\"type\":\"${"principal"}\" ${ico}}' >"
                    tree += "<li id='gp_" + hijo.id + "' class='" + clase + "' ${data} data-tipo='${Grupo.get(hijo.id)?.id}' data-jstree='{\"type\":\"${"principal"}\" ${ico}}' >"
                    tree += "<a href='#' class='label_arbol'>" + hijo?.descripcion + "</a>"
                    tree += "</li>"
                }
            }else{
                switch(tipo) {
                    case "gp":
                        hijos = Subgrupo.findAllByGrupo(Grupo.get(id), [sort: 'id'])
                        liId = "sg_"
                        ico = ", \"icon\":\"fa fa-copyright text-info\""
                        hijos.each { h ->
                            clase = Producto.findBySubgrupo(h) ? "jstree-closed hasChildren" : ""
                            tree += "<li id='" + liId + h.id + "' class='" + clase + "' data-tipo='${Grupo.get(params.tipo)?.id}' data-jstree='{\"type\":\"${"subgrupo"}\" ${ico}}'>"
                            tree += "<a href='#' class='label_arbol'>"  +  "<strong>" + " "  + "</strong>" +  h.descripcion + "</a>"
                            tree += "</li>"
                        }
                        break
                    case "sg":
                        hijos = Producto.findAllBySubgrupo(SubgrupoItems.get(id), [sort: 'orden'])
                        liId = "dp_"
                        ico = ", \"icon\":\"fa fa-registered text-danger\""
//                        hijos.each { h ->
//                            clase = Item.findByDepartamento(h)? "jstree-closed hasChildren" : ""
//                            tree += "<li id='" + liId + h.id + "' class='" + clase + "'  data-tipo='${Grupo.get(params.tipo)?.id}' data-jstree='{\"type\":\"${"departamento"}\" ${ico}}'>"
//                            if(Grupo.get(params.tipo)?.id == 2){
//                                tree += "<a href='#' class='label_arbol'>" +  "<strong>"  + "" + h?.codigo + " " + "</strong>"  + h.descripcion + "</a>"
//                            }else{
//                                tree += "<a href='#' class='label_arbol'>" +  "<strong>"  + "" + h?.subgrupo?.codigo + "." +  h?.codigo + " " + "</strong>"  + h.descripcion + "</a>"
//                            }
//                            tree += "</li>"
//                        }
                        break
//                    case "dp":
//                        hijos = Item.findAllByDepartamento(DepartamentoItem.get(id), [sort: 'codigo'])
//                        liId = "it_"
//                        ico = ", \"icon\":\"fa fa-info-circle text-warning\""
//                        hijos.each { h ->
//                            if(params.vae){
//                                clase = VaeItems.findAllByItem(h)? "jstree-closed hasChildren" : ""
//                            }else{
//                                clase = ""
//                            }
//                            tree += "<li id='" + liId + h.id + "' class='" + clase + "' data-tipo='${Grupo.get(params.tipo)?.id}' data-jstree='{\"type\":\"${"item"}\" ${ico}}'>"
//                            tree += "<a href='#' class='label_arbol'>" +  "<strong>" + "" + h?.codigo + " " + "</strong>" + h.nombre + "</a>"
//                            tree += "</li>"
//                        }
//                        break

//                    case "it":
//                        hijos =  VaeItems.findAllByItem(Item.get(id),[max:1])
//                        liId = "vae_"
//                        ico = ", \"icon\":\"fa fa-info-circle text-info\""
//                        hijos.each { h ->
//                            clase = ""
//                            tree += "<li id='" + liId + h.id + "' class='" + clase + "' data-tipo='${Grupo.get(params.tipo)?.id}' data-jstree='{\"type\":\"${"vae"}\" ${ico}}'>"
//                            tree += "<a href='#' class='label_arbol'>" +  "<strong>" + "VAE" + "</strong>" + "</a>"
//                            tree += "</li>"
//                        }
//                        break
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
        def subgrupo

        if(params.id){
            subgrupo = Subgrupo.get(params.id)
        }else{
            subgrupo = new Subgrupo()
        }

        return [subgrupo: subgrupo]
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

}
