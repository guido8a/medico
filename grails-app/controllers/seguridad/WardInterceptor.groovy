package seguridad

class WardInterceptor {

    WardInterceptor () {
//        matchAll().excludes(controller: 'login')
        matchAll().excludes(controller:'apis')
                .excludes(controller:'login')
                .excludes(controller:'descargas')
                .excludes(controller:'shield')
                .excludes(controller:'prfl')
    }

    boolean before() {
//        println "acción: " + actionName + " controlador: " + controllerName + " params: $params"
//        println "shield sesión: " + session
//        println "usuario: " + session.usuario
        session.an = actionName
        session.cn = controllerName
        session.pr = params
        def usro

        if( actionName.toString().toLowerCase().contains('save') ){
            if(!session){
                println("graba sin sesión")
            } else {
                println "session: ${session.usuario}"
            }
            flash.clase = "alert-success"
            flash.message = "Se han guardado los datos y terminado la sesión por inactividad en el sistema"

            return true
        }

        if(session) {
            usro = session.usuario
        }

        def app = ""

        if (grails.util.Environment.getCurrent().name == 'development') {
            app = '/'
        } else {
            app = '/medico/'
        }

        if(session.an == 'saveTramite' && session.cn == 'tramite'){
            println("entro")
            return true
        } else {
            if (!session?.usuario || !session?.perfil) {
                println "...sin sesión"
                if(controllerName != "inicio" && actionName != "index") {
//                    flash.message = "Usted ha superado el tiempo de inactividad máximo de la sesión"
                }
                render "<script type='text/javascript'> window.location.href = '${app}' </script>"
                session.finalize()
                return false
            }

//            if (!session?.usuario && !session?.perfil) {
//                if(controllerName != "inicio" && actionName != "index") {
////                    flash.message = "Usted ha superado el tiempo de inactividad máximo de la sesión"
//                }
//                println "redireccionando a raiz de aplicación: $app"
//                render "<script type='text/javascript'> window.location.href = '${app}' </script>"
//                session.finalize()
                return true
//            }
        }

        true
    }

    boolean after() {
//        println "+++++después"
        true
    }

    void afterView() {
//        println "+++++afterview"
        // no-op
    }


    boolean isAllowed() {
//        println "--> ${session.permisos[controllerName.toLowerCase()]} --> ${actionName}"
//
//        try {
//            if((request.method == "POST") || (actionName.toLowerCase() =~ 'ajax')) {
//                println "es post no audit"
//                return true
//            }
////            println "is allowed Accion: ${actionName.toLowerCase()} ---  Controlador: ${controllerName.toLowerCase()} --- Permisos de ese controlador: "+session.permisos[controllerName.toLowerCase()]
//            if (!session.permisos[controllerName.toLowerCase()]) {
//                return false
//            } else {
//                if (session.permisos[controllerName.toLowerCase()].contains(actionName.toLowerCase())) {
//                    return true
//                } else {
//                    return false
//                }
//            }
//
//        } catch (e) {
//            println "Shield execption e: " + e
//            return false
//        }

        return true

    }

}
