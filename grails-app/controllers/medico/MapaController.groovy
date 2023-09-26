package medico

class MapaController {

    def dbConnectionService

    def index() { }

    def mapa(){
        println "mapa: $params"
        def cn = dbConnectionService.getConnection()
        def sql = ""
        def coord = '', nmbr = '', txto = '', prdo = 0, periodo, dcmt, cntn = ""
        def visita

        sql = "select fnca__id, fncanmbr, fncacmnd, fncalong, fncalatt from fnca"
        println "sql: $sql"

        cn.eachRow(sql.toString()) { d ->
            coord += (coord ? '_' : '') + "${d.fncalatt} ${d.fncalong} 1"
            dcmt += (coord ? '_' : '') + "${d.fncalatt} ${d.fncalong} 1"
            cntn += (cntn ? '_' : '') + "${d.fnca__id}"
            txto = "${d.fncanmbr} kkComunidad: ${d.fncacmnd}"

            nmbr += (nmbr ? '_' : '') + txto
        }

        //${assetPath(src: '/apli/pin-p.png')}
//        println "--> cntn: $cntn"
        return [cord: coord, nmbr: nmbr, cntn: cntn, pr: 2]

    }

}
