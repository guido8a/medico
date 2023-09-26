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
                                <g:link data-info="categoria" class="over tamano" controller="institucion" action="list" >
                                    <i class="fa-li fas fa-certificate text-info"></i> Instituciones
                                </g:link>

                                <div class="descripcion hidden">
                                    <h4>Instituciones</h4>

                                    <p> Administración de las diferentes instituciones
                                    </p>
                                </div>
                            </li>

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
                                <g:link class="over tamano" controller="tipoLote" action="list">
                                    <i class="fa-li fas fa-scroll text-info "></i>
                                    Tipo de Lote
                                </g:link>

                                <div class="descripcion hidden">
                                    <h4>Tipo de Lote</h4>

                                    <p>Administracion del tipo de lote</p>
                                </div>
                            </li>

                            <li>
                                <g:link class="over tamano" controller="familia" action="list">
                                    <i class="fa-li fas fa-scroll text-info "></i>
                                    Familias
                                </g:link>

                                <div class="descripcion hidden">
                                    <h4>Familias</h4>

                                    <p>Administracion de los tipos de integrantes que constan en una familia</p>
                                </div>
                            </li>

                            <li>
                                <g:link class="over tamano" controller="tipoObra" action="list">
                                    <i class="fa-li fas fa-scroll text-info "></i>
                                    Tipo de Obra
                                </g:link>

                                <div class="descripcion hidden">
                                    <h4>Tipo de Obra</h4>

                                    <p>Administracion del tipo de obra</p>
                                </div>
                            </li>

                            <li>
                                <g:link class="over tamano" controller="planta" action="list">
                                    <i class="fa-li fas fa-scroll text-info "></i>
                                    Plantas
                                </g:link>

                                <div class="descripcion hidden">
                                    <h4>Tipo de Plantas</h4>

                                    <p>Administracion de tipos de plantas</p>
                                </div>
                            </li>

                            <li>
                                <g:link class="over tamano" controller="enfermedad" action="list">
                                    <i class="fa-li fas fa-scroll text-info "></i>
                                    Enfermedades
                                </g:link>

                                <div class="descripcion hidden">
                                    <h4>Enfermedades</h4>

                                    <p>Administracion de enfermedades</p>
                                </div>
                            </li>

                            <li>
                                <g:link class="over tamano" controller="plaga" action="list">
                                    <i class="fa-li fas fa-scroll text-info "></i>
                                    Plagas
                                </g:link>

                                <div class="descripcion hidden">
                                    <h4>Plagas</h4>

                                    <p>Administracion de plagas</p>
                                </div>
                            </li>

                            <li>
                                <g:link class="over tamano" controller="siembra" action="list">
                                    <i class="fa-li fas fa-scroll text-info "></i>
                                    Tipo de Siembra
                                </g:link>

                                <div class="descripcion hidden">
                                    <h4>Tipo de Siembra</h4>

                                    <p>Administracion de tipo de siembra</p>
                                </div>
                            </li>

                            <li>
                                <g:link class="over tamano" controller="animal" action="list">
                                    <i class="fa-li fas fa-scroll text-info "></i>
                                    Animales
                                </g:link>

                                <div class="descripcion hidden">
                                    <h4>Animales</h4>

                                    <p>Administracion de animales</p>
                                </div>
                            </li>

                            <li>
                                <g:link class="over tamano" controller="equipo" action="list">
                                    <i class="fa-li fas fa-scroll text-info "></i>
                                    Instalaciones
                                </g:link>

                                <div class="descripcion hidden">
                                    <h4>Instalaciones</h4>

                                    <p>Administración de instalaciones</p>
                                </div>
                            </li>

                            <li>
                                <g:link class="over tamano" controller="capacitacion" action="list">
                                    <i class="fa-li fas fa-scroll text-info "></i>
                                    Capacitaciones
                                </g:link>

                                <div class="descripcion hidden">
                                    <h4>Capacitaciones</h4>

                                    <p>Administración de capacitaciones</p>
                                </div>
                            </li>

                            <li>
                                <g:link class="over tamano" controller="cargo" action="list">
                                    <i class="fa-li fas fa-scroll text-info "></i>
                                    Cargos
                                </g:link>

                                <div class="descripcion hidden">
                                    <h4>Cargos</h4>

                                    <p>Administración de cargos</p>
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