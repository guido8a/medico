<html>


<head>
    <meta name="layout" content="main"/>


    <title>Parámetros</title>

    <style type="text/css">

    .tab-content, .left, .right {
        height : 600px;
    }

    .tab-content {
        /*background  : #EFE4D1;*/
        background  : #EEEEEE;
        border      : solid 1px #DDDDDD;
        padding-top : 10px;
    }

    .descripcion {
        /*margin-left : 20px;*/
        font-size : 12px;
        border    : solid 2px cadetblue;
        padding   : 0 10px;
        margin    : 0 10px 0 0;
    }

    .info {
        font-style : italic;
        color      : navy;
    }

    .descripcion h4 {
        color      : cadetblue;
        text-align : center;
    }

    .left {
        width : 710px;
        /*background : red;*/
    }

    .right {
        width       : 300px;
        margin-left : 40px;
        /*background  : blue;*/
    }

    .fa-ul li {
        margin-bottom : 10px;
    }

    .uno {

        float      : left;
        width      : 150px;
        margin-top : 10px;
    }

    .dos {

        float      : left;
        width      : 250px;
        margin-top : 10px;
    }

    .fila {
        height : 40px;
    }

    .textoUno {
        float : left;
        width : 250px;

    }

    .textoDos {
        float : left;

    }


    .btn-sq-lg {
        width: 150px !important;
        height: 150px !important;
    }

    .btn-sq {
        width: 100px !important;
        height: 100px !important;
        font-size: 10px;
    }

    .btn-sq-sm {
        width: 50px !important;
        height: 50px !important;
        font-size: 10px;
    }

    .btn-sq-xs {
        width: 25px !important;
        height: 25px !important;
        padding:2px;
    }

    </style>

</head>

<body>

<div class="row">
    <div class="col-md-6"style="text-align: center;">

        <div class="panel panel-primary">
            <div class="panel-heading">
                <h3 class="panel-title">Parámetros del Sistema</h3>
            </div>

            <div class="row">
                <div class="col-md-12 col-xs-5">
                    <p>
                        <g:link data-info="categoria" class="link btn btn-primary btn-ajax" controller="canton" action="arbol">
                            <i class="fa fa-globe fa-5x"></i><br/>
                            Distribución Geográfica
                        </g:link>
                    </p>
                </div>
            </div>

            <div class="row">
                <div class="col-md-12 col-xs-5">
                    <p>
                        <g:link data-info="categoria" class="link btn btn-warning btn-ajax" controller="institucion" action="list" >
                            <i class="fa fa-building fa-5x"></i><br/> Instituciones
                        </g:link>

                        <g:link class="link btn btn-warning btn-ajax" controller="familia" action="list">
                            <i class="fa fa-home fa-5x"></i><br/>
                            Familias
                        </g:link>

                        <g:link class="link btn btn-warning btn-ajax" controller="tipoLote" action="list">
                            <i class="fa fa-map fa-5x"></i><br/>
                            Tipo de Lote
                        </g:link>

                        <g:link class="link btn btn-warning btn-ajax" controller="tipoObra" action="list">
                            <i class="fa fa-book fa-5x"></i><br/>
                            Tipo de Obra
                        </g:link>

                    </p>
                </div>
            </div>

            <div class="row">
                <div class="col-md-12 col-xs-5">
                    <p>
                        <g:link class="link btn btn-success btn-ajax" controller="planta" action="list">
                            <i class="fa fa-tree fa-5x"></i><br/>
                            Plantas
                        </g:link>

                        <g:link class="link btn btn-success btn-ajax" controller="animal" action="list">
                            <i class="fa fa-paw fa-5x"></i><br/>
                            Animales
                        </g:link>

                        <g:link class="link btn btn-success btn-ajax" controller="enfermedad" action="list">
                            <i class="fa fa-certificate fa-5x"></i><br/>
                            Enfermedades
                        </g:link>

                        <g:link class="link btn btn-success btn-ajax" controller="plaga" action="list">
                            <i class="fa fa-asterisk fa-5x"></i><br/>
                            Plagas
                        </g:link>

                        <g:link class="link btn btn-success btn-ajax" controller="siembra" action="list">
                            <i class="fa fa-book fa-5x"></i><br/>
                            Tipo de Siembra
                        </g:link>
                    </p>
                </div>
            </div>

            <div class="row">
                <div class="col-md-12 col-xs-5">
                    <p>
                        <g:link class="link btn btn-info btn-ajax" controller="equipo" action="list">
                            <i class="fa fa-wrench fa-5x"></i><br/>
                            Instalaciones
                        </g:link>

                        <g:link class="link btn btn-info btn-ajax" controller="capacitacion" action="list">
                            <i class="fa fa-calendar fa-5x"></i><br/>
                            Capacitaciones
                        </g:link>

                        <g:link class="link btn btn-info btn-ajax" controller="cargo" action="list">
                            <i class="fa fa-users fa-5x"></i><br/>
                            Cargos
                         </g:link>

                    </p>
                </div>
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