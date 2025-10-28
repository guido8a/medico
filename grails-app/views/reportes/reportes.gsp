
<%@ page contentType="text/html" %>

<html>
<head>
    <meta name="layout" content="main"/>
    <title>Reportes</title>

    <style type="text/css">

    .tab-content, .left, .right {
        height : 500px;
    }

    .tab-content {
        background    : #EEEEEE;
        border-left   : solid 1px #DDDDDD;
        border-bottom : solid 1px #DDDDDD;
        border-right  : solid 1px #DDDDDD;
        padding-top   : 10px;
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
        width : 600px;
        text-align: justify;
        /*background : red;*/
    }

    .right {
        width       : 300px;
        margin-left : 20px;
        padding: 20px;
        /*background  : blue;*/
    }

    .fa-ul li {
        margin-bottom : 10px;
    }

    .example_c {
        color: #808b9d !important;
        /*text-transform: uppercase;*/
        text-decoration: none;
        background: #ffffff;
        padding: 20px;
        border: 4px solid #78b665 !important;
        display: inline-block;
        transition: all 0.4s ease 0s;
    }

    .example_c:hover {
        color: #ffffff !important;
        background: #f6b93b;
        border-color: #f6b93b !important;
        transition: all 0.4s ease 0s;
    }


    .mensaje {
        color: #494949 !important;
        /*text-transform: uppercase;*/
        text-decoration: none;
        background: #ffffff;
        padding: 20px;
        border: 4px solid #f6b93b !important;
        display: inline-block;
        transition: all 0.4s ease 0s;
    }

    </style>


</head>

<body>


<g:set var="iconGen" value="fa fa-cog"/>
<g:set var="iconEmpr" value="fa fa-building-o"/>

%{--<ul class="nav nav-tabs">--}%
<ul class="nav nav-pills">
    <li class="active"><a data-toggle="pill" href="#generales">Generales</a></li>
    <li class=""><a data-toggle="pill" href="#contabilidad">Contabilidad</a></li>
    %{--    <li><a data-toggle="pill" href="#obra">POA</a></li>--}%
    %{--    <li><a data-toggle="pill" href="#cont">Datos geográficos</a></li>--}%
</ul>

<div class="tab-content">
    <div id="generales" class="tab-pane fade in active">

        <div class="row">
            <div class="col-md-12 col-xs-5">
                <p>

                    <a href="#" id="btnReporteCitas" class="btn btn-info btn-ajax example_c item" texto="fnca">
                        <i class="fa fa-print fa-4x text-success"></i>
                        <br/> Citas por paciente
                    </a>
                    %{--                    <a href="#" id="btnSocios" class="btn btn-info btn-ajax example_c item" texto="dire">--}%
                    %{--                        <i class="fa fa-users fa-4x text-success"></i>--}%
                    %{--                        <br/> Socios--}%
                    %{--                    </a>--}%
                    %{--                    <a href="#" id="btnEncuestas" class="btn btn-info btn-ajax example_c item" texto="undd">--}%
                    %{--                        <i class="fa fa-paste fa-4x text-success"></i>--}%
                    %{--                        <br/> Encuestas--}%
                    %{--                    </a>--}%
                </p>
            </div>
        </div>

        %{--        <div class="row">--}%
        %{--            <div class="col-md-12 col-xs-5">--}%
        %{--                <p>--}%
        %{--                    <a href="#" id="btnTalleres" class="btn btn-info btn-ajax example_c item" texto="func">--}%
        %{--                        <i class="fa fa-book-medical fa-4x text-success"></i>--}%
        %{--                        <br/> Talleres--}%
        %{--                    </a>--}%
        %{--                    <a href="#" id="btnCapacitaciones" class="btn btn-info btn-ajax example_c item" texto="ddlb">--}%
        %{--                        <i class="fa fa-atlas fa-4x text-success"></i>--}%
        %{--                        <br/> Capacitaciones--}%
        %{--                    </a>--}%
        %{--                    <a href="#" id="btnConvenios" class="btn btn-info btn-ajax example_c item" texto="auxl">--}%
        %{--                        <i class="fa fa-handshake fa-4x text-success"></i>--}%
        %{--                        <br/> Convenios--}%
        %{--                    </a>--}%
        %{--                </p>--}%
        %{--            </div>--}%
        %{--        </div>--}%
    </div>
    <div id="contabilidad" class="tab-pane fade in">
        <div class="row">
            <div class="col-md-12 col-xs-5">
                <p>

                    <a href="#" id="btnPlanCuentas" class="btn btn-info btn-ajax example_c item" texto="plan">
                        <i class="fa fa-sitemap fa-4x text-success"></i>
                        <br/> Plan de Cuentas
                    </a>
                    <a href="#" id="btnGestorContable" class="btn btn-info btn-ajax example_c item" texto="gestor">
                        <i class="fa fa-building fa-4x text-success"></i>
                        <br/>  Gestor Contable
                    </a>
                    <a href="#" id="btnLibroDiario" class="btn btn-info btn-ajax example_c item" texto="diario">
                        <i class="fa fa-bookmark fa-4x text-success"></i>
                        <br/>  Libro diario
                    </a>
                    <a href="#" id="btnLibroMayor" class="btn btn-info btn-ajax example_c item" texto="mayor">
                        <i class="fa fa-book fa-4x text-success"></i>
                        <br/>  Libro mayor
                    </a>
                </p>
            </div>
        </div>
    </div>

    <div id="tool" style="margin-left: 350px; width: 300px; height: 160px; display: none;padding:25px;"
         class="ui-widget-content ui-corner-all mensaje">
    </div>

</div>

<div id="fnca" style="display:none">
    <h3>Reporte de citas por pacientes</h3><br>
    <p>Listado de todos las citas por paciente</p>
</div>

<div id="plan" style="display:none">
    <h3>Plan de Cuentas</h3><br>
    <p>Listado de plan de cuenta</p>
</div>

<div id="gestor" style="display:none">
    <h3>Gestor Contable</h3><br>
    <p>Listado de gestores contables</p>
</div>

<div id="mayor" style="display:none">
    <h3>Libro mayor</h3><br>
    <p>Libro mayor</p>
</div>

<div id="diario" style="display:none">
    <h3>Libro diario</h3><br>
    <p>Libro diario</p>
</div>

<script type="text/javascript">

    var bca, dlm;

    $("#btnLibroDiario").click(function () {
        $.ajax({
            type: "POST",
            url: "${createLink(controller: 'reportes', action:'libroDiario_ajax')}",
            data: {  },
            success: function (msg) {
                var b = bootbox.dialog({
                    title: "Libro diario",
                    closeButton: false,
                    message: msg,
                    buttons: {
                        cancelar: {
                            label: "<i class='fa fa-times'></i> Cancelar",
                            className: "btn-primary",
                            callback: function () {
                            }
                        },
                        crear: {
                            label: "<i class='fa fa-print'></i> Imprimir",
                            className: "btn-success",
                            callback: function () {
                                var cont = $("#contabilidadDiario option:selected").val();
                                var per = $("#periodoLibroDiario option:selected").val();
                                location.href = "${g.createLink(controller: 'reportes', action: '_libroDiario')}?cont=" + cont + "&periodo=" + per + "&empresa=${session.empresa.id}";
                            }
                        }
                    }
                }); //dialog
            } //success
        });
    });


    $("#btnLibroMayor").click(function () {
        $.ajax({
            type: "POST",
            url: "${createLink(controller: 'reportes', action:'libroMayor_ajax')}",
            data: {  },
            success: function (msg) {
                dlm = bootbox.dialog({
                    title: "Libro Mayor",
                    closeButton: false,
                    message: msg,
                    buttons: {
                        cancelar: {
                            label: "<i class='fa fa-times'></i> Cancelar",
                            className: "btn-primary",
                            callback: function () {
                            }
                        },
                        crear: {
                            label: "<i class='fa fa-print'></i> Imprimir",
                            className: "btn-success",
                            callback: function () {
                                var fechaDesde = $("#fechaDesde").val();
                                var fechaHasta = $("#fechaHasta").val();
                                $.ajax({
                                    type: 'POST',
                                    url: '${createLink(controller: 'reportes', action: 'revisarFecha_ajax')}',
                                    data:{
                                        desde: fechaDesde,
                                        hasta: fechaHasta
                                    },
                                    success: function (msg){
                                        var cont = $("#contCuentas").val();
                                        var cnta = $("#idCntaLibro").val();
                                        if(msg === 'ok'){
                                            if(cont){
                                                if(cnta){
                                                    location.href = "${g.createLink(controller:'reportes' , action: '_libroMayor')}?cont=" + cont + "&emp=${session.empresa.id}" + "&cnta=" + cnta + "&desde=" + fechaDesde + "&hasta=" + fechaHasta;
                                                    cerrarImprimirLibroMayor();
                                                }else{
                                                    bootbox.alert("<i class='fa fa-exclamation-triangle fa-3x pull-left text-info text-shadow'></i> <strong style='font-size: 14px'> Seleccione una cuenta </strong> ");
                                                    return false;
                                                }
                                            }else{
                                                bootbox.alert("<i class='fa fa-exclamation-triangle fa-3x pull-left text-info text-shadow'></i> <strong style='font-size: 14px'> Seleccione una contabilidad </strong> ");
                                                return false;
                                            }
                                        }else{
                                            bootbox.alert("<i class='fa fa-exclamation-triangle fa-3x pull-left text-info text-shadow'></i> <strong style='font-size: 14px'> La fecha ingresada en 'Hasta' es menor a la fecha ingresada en 'Desde' </strong> ");
                                            return false;
                                        }
                                    }
                                });
                                return false
                            }
                        }
                    }
                }); //dialog
            } //success
        });
    });

    $("#btnPlanCuentas").click(function () {
        $.ajax({
            type: "POST",
            url: "${createLink(controller: 'reportes', action:'planCuentas_ajax')}",
            data: {  },
            success: function (msg) {
                var b = bootbox.dialog({
                    title: "Plan de cuentas",
                    closeButton: false,
                    message: msg,
                    buttons: {
                        cancelar: {
                            label: "<i class='fa fa-times'></i> Cancelar",
                            className: "btn-primary",
                            callback: function () {
                            }
                        },
                        crear: {
                            label: "<i class='fa fa-print'></i> Imprimir",
                            className: "btn-success",
                            callback: function () {
                                var cont = $("#contCuentas").val();
                                location.href = "${g.createLink(controller:'reportes' , action: '_planDeCuentas')}?cont=" + cont + "&empresa=${session.empresa?.id}";
                            }
                        }
                    }
                }); //dialog
            } //success
        });
    });

    $("#btnGestorContable").click(function () {
        $.ajax({
            type: "POST",
            url: "${createLink(controller: 'reportes', action:'gestorContable_ajax')}",
            data: {  },
            success: function (msg) {
                var b = bootbox.dialog({
                    title: "Gestor contable",
                    closeButton: false,
                    message: msg,
                    buttons: {
                        cancelar: {
                            label: "<i class='fa fa-times'></i> Cancelar",
                            className: "btn-primary",
                            callback: function () {
                            }
                        },
                        crear: {
                            label: "<i class='fa fa-print'></i> Imprimir",
                            className: "btn-success",
                            callback: function () {
                                var cont = $("#contCuentas").val();
                                location.href = "${g.createLink(controller:'reportes' , action: '_gestorContable')}?cont=" + cont + "&empresa=${session.empresa?.id}";
                            }
                        }
                    }
                }); //dialog
            } //success
        });
    });

    $("#btnReporteCitas").click(function () {
        $.ajax({
            type: "POST",
            url: "${createLink(controller: 'reportes', action:'listaPacientes_ajax')}",
            data: {  },
            success: function (msg) {
                var b = bootbox.dialog({
                    title: "Reporte de citas",
                    closeButton: false,
                    message: msg,
                    buttons: {
                        cancelar: {
                            label: "<i class='fa fa-times'></i> Cancelar",
                            className: "btn-primary",
                            callback: function () {
                            }
                        },
                        crear: {
                            label: "<i class='fa fa-print'></i> Imprimir",
                            className: "btn-success",
                            callback: function () {
                                location.href = "${g.createLink(controller:'reportes', action: 'reporteCitasXPaciente')}?paciente=" + $("#paciente").val();
                            }
                        }
                    }
                }); //dialog
            } //success
        });
    });

    function prepare() {
        $(".fa-ul li span").each(function () {
            var id = $(this).parents(".tab-pane").attr("id");
            var thisId = $(this).attr("id");
            $(this).siblings(".descripcion").addClass(thisId).addClass("ui-corner-all").appendTo($(".right." + id));
        });
    }

    $(function () {
        prepare();
        $(".fa-ul li span").hover(function () {
            var thisId = $(this).attr("id");
            $("." + thisId).removeClass("hide");
        }, function () {
            var thisId = $(this).attr("id");
            $("." + thisId).addClass("hide");
        });
    });

    $(document).ready(function () {
        $('.item').hover(function () {
            $('#tool').html($("#" + $(this).attr('texto')).html());
            $('#tool').show();
        }, function () {
            $('#tool').hide();
        });
    });

    function buscarCuentas() {
        $.ajax({
            type: 'POST',
            url:'${createLink(controller: 'cuenta', action: 'buscadorCuentas_ajax')}',
            data:{ },
            success: function (msg){
               bca = bootbox.dialog({
                    title: 'Buscar cuenta',
                    message: msg,
                    class: 'long',
                    buttons:{
                        cancelar: {
                            label: "<i class='fa fa-times'></i> Cancelar",
                            className: "btn-primary",
                            callback: function () {
                            }
                        }
                    }
                })
            }
        });
    }

    function cerrarBuscarCuenta() {
        bca.modal("hide");
    }

    function cerrarImprimirLibroMayor() {
        dlm.modal("hide");
    }


</script>
</body>
</html>
