package medico

class ProductoController {

    def arbol(){
        //<!--grpo--><!--sbgr -> Grupo--><!--dprt -> Subgrupo--><!--item-->
        //materiales = 1
        //mano de obra = 2
        //equipo = 3
        def hh = Grupo.count()
        return [hh: hh]
    }


}
