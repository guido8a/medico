package medico

import groovy.io.FileType
import seguridad.Persona

class BaseController {



    def base() {
        def base = Base.get(params.id)

        def list = []
        def dir = new File("/var/medico/bitacora/${base?.id}")
        if (dir.size() > 0) {
            dir.eachFileRecurse(FileType.FILES) { file ->
                list << file
            }
        }

        def partes = []
        def contadorImas = 0
        def contadorOtros = 0

        list.each {
            partes = it.name.split("\\.")
            if (partes[1] in ['jpeg', 'png', 'jpg']) {
                contadorImas++
            } else {
                contadorOtros++
            }

        }

        return [base: base, lista: list, contadorImas: contadorImas, contadorOtros: contadorOtros]
    }

    def tablaArchivos() {

        println("params ta " + params)

        def base = params.id
        def list = []
        def dir = new File("/var/medico/bitacora/${base}")
        if (dir.size() > 0) {

            dir.eachFileRecurse(FileType.FILES) { file ->
                list << file.canonicalFile
            }
        }
        return [lista: list, base: base, bandera: params.band]
    }

    def guardarProblema_ajax() {

        def tema = Tema.get(params.tema)
        def usuario = Persona.get(session.usuario.id)
        def baseInstance
        def edita = params.id ? params.id : 0

        if (params.id) {
            baseInstance = Base.get(params.id)
        } else {
            baseInstance = new Base()
            baseInstance.fecha = new Date()
            baseInstance.persona = usuario

        }
        baseInstance.properties = params
        baseInstance.tema = tema

        try {
            baseInstance.save(flush: true)
            baseInstance.refresh()
            render "ok_${baseInstance.id}"

        } catch (e) {
            println("error al guardar el problema " + baseInstance.errors)
            render "no"
        }
    }

    def show_ajax() {
        def base = Base.get(params.id)
        def list = []
        def dir = new File("/var/bitacora/${base?.id}")
        if (dir.size() > 0) {
            dir.eachFileRecurse(FileType.FILES) { file ->
                list << file
            }
        }
        return [baseInstance: base, lista: list]
    }

    def validarProblema_ajax() {
        def problema = params.problema

        if (problema.size() < 15) {
            render false
            return
        } else {
            render true
            return
        }
    }

    def validarClave_ajax() {
        def clave = params.clave

        if (clave.size() < 3) {
            render false
            return
        } else {
            render true
            return
        }
    }



}
