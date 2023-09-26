package utilitarios

class DescargasController {

    def manual() {
        println "manual: $params"
        def nombre = 'manual.pdf'
        def path = '/var/rkch/manual.pdf'
        def file = new File(path)
        def b = file.getBytes()
        response.setContentType('pdf')
        response.setHeader("Content-disposition", "attachment; filename=" + nombre)
        response.setContentLength(b.length)
        response.getOutputStream().write(b)
    }

    def aplicacion() {
        println "aplicación: $params"
        def nombre = 'medico.apk'
        def path = '/var/rkch/medico.apk'
        def file = new File(path)
        def b = file.getBytes()
        response.setContentType('octet-stream')
        response.setHeader("Content-disposition", "attachment; filename=" + nombre)
        response.setContentLength(b.length)
        response.getOutputStream().write(b)
    }

    def manual_movil() {
        println "manual_movil: $params"
        def nombre = 'manual_movil.pdf'
        def path = '/var/rkch/manual móvil.pdf'
        def file = new File(path)
        def b = file.getBytes()
        response.setContentType('pdf')
        response.setHeader("Content-disposition", "attachment; filename=" + nombre)
        response.setContentLength(b.length)
        response.getOutputStream().write(b)
    }

} //fin controller
