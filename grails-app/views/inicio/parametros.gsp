<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Parámetros</title>

        <style type="text/css">
        ul {padding:0.2em}
        li {padding:0.2em}
            .tamano{
                font-size: 16px;
            }
        </style>
    </head>

    <body>

        <div class="row">
            <div class="col-md-4">

                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title">Parámetros del Sistema</h3>
                    </div>

                    <div class="panel-body">
                        <ul class="fa-ul">

                            <li>
                                <g:link data-info="categoria" class="over tamano" controller="canton" action="arbol">
                                    <i class="fa-li fas fa-map-marker-alt text-info"></i>
                                    Distribución Geográfica
                                </g:link>

                                <div class="descripcion hidden">
                                    <h4>Distribución geográfica de Ecuador</h4>

                                    <p>Permitirá referenciar geográficamente las metas del proyeto y los lugares donde
                                        se firmen los Convenios.
                                    </p>
                                    <p>Cuenta con las provincias, cantones y parroquias.
                                    </p>
                                </div>
                            </li>

                            <li>
                                <g:link data-info="categoria" class="over tamano" controller="diagnostico" action="list" >
                                    <i class="fa-li fas fa-certificate text-info"></i> Diagnóstico
                                </g:link>

                                <div class="descripcion hidden">
                                    <h4>Diagnóstico</h4>

                                    <p> Administración de las diferentes Diagnóstico
                                    </p>
                                </div>
                            </li>

                            <li>
                                <g:link data-info="categoria" class="over tamano" controller="examen" action="list" >
                                    <i class="fa-li fas fa-certificate text-info"></i> Exámenes
                                </g:link>

                                <div class="descripcion hidden">
                                    <h4>Exámenes</h4>

                                    <p> Administración de las diferentes exámenes
                                    </p>
                                </div>
                            </li>

                            <li>
                                <g:link data-info="categoria" class="over tamano" controller="tipoExamen" action="list" >
                                    <i class="fa-li fas fa-certificate text-info"></i> Tipos de Exámenes
                                </g:link>

                                <div class="descripcion hidden">
                                    <h4>Tipos de Exámenes</h4>

                                    <p> Administración de las diferentes tipos de exámenes
                                    </p>
                                </div>
                            </li>

                            <li>
                                <g:link data-info="categoria" class="over tamano" controller="tema" action="list" >
                                    <i class="fa-li fas fa-certificate text-info"></i> Especialidad médica
                                </g:link>

                                <div class="descripcion hidden">
                                    <h4>Especialidad médica</h4>

                                    <p> Administración de especialidades médicas de las guías y protocolos
                                    </p>
                                </div>
                            </li>

                            <li>
                                <g:link data-info="categoria" class="over tamano" controller="subtema" action="list" >
                                    <i class="fa-li fas fa-certificate text-info"></i> Tipología
                                </g:link>

                                <div class="descripcion hidden">
                                    <h4>Tipología</h4>

                                    <p> Administración de tipología de las guías y protocolos
                                    </p>
                                </div>
                            </li>

                            <li>
                                <g:link data-info="categoria" class="over tamano" controller="tipoMedico" action="list" >
                                    <i class="fa-li fas fa-certificate text-info"></i> Tipo de usuarios
                                </g:link>

                                <div class="descripcion hidden">
                                    <h4>Tipos de usuarios</h4>

                                    <p> Administración de los diferentes tipos de usuarios del sistema
                                    </p>
                                </div>
                            </li>

                            <li>
                                <g:link data-info="categoria" class="over tamano" controller="laboratorio" action="list" >
                                    <i class="fa-li fas fa-certificate text-info"></i> Laboratorios
                                </g:link>

                                <div class="descripcion hidden">
                                    <h4>Laboratorios</h4>

                                    <p> Administración de los diferentes tipos laboratorios
                                    </p>
                                </div>
                            </li>


                        </ul>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="panel panel-info right hidden">
                    <div class="panel-heading">
                        <h3 class="panel-title"></h3>
                    </div>

                    <div class="panel-body">

                    </div>
                </div>
            </div>
        </div>

        <script type="text/javascript">
            $(function () {
                $(".over").hover(function () {
                    var $h4 = $(this).siblings(".descripcion").find("h4");
                    var $cont = $(this).siblings(".descripcion").find("p");
                    $(".right").removeClass("hidden").find(".panel-title").text($h4.text()).end().find(".panel-body").html($cont.html());
                }, function () {
                    $(".right").addClass("hidden");
                });
            });
        </script>

    </body>
</html>