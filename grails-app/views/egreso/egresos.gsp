
<%
    def buscadorServ = grailsApplication.classLoader.loadClass('utilitarios.BuscadorService').newInstance()
%>



<html>
<head>
    <meta name="layout" content="main">
    <asset:javascript src="/Toggle-Button-Checkbox/js/bootstrap-checkbox.js"/>

    <title>Egresos y gastos</title>

    <style type="text/css">
    .alinear {
        text-align: center !important;
    }
    .selecionado {
        background-color: #ffffdf;
    }
    </style>

</head>

<body>

%{--<elm:message tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:message>--}%
<div style="text-align: center;">
    <h3 class="breadcrumb">Egresos</h3>
</div>

%{--    <div style="float: right; margin-top: -30px; height: 30px;" class="badge badge-secondary" >--}%
%{--        <input type="checkbox" value="Saldo > 0" id="saldo"> Mostrar saldos pendientes--}%
%{--    </div>--}%

<div class="row">
    <div class="col-md-12">
        <div class="col-md-8">
            <div class="btn-group">
                <a href="#" name="busqueda" class="btn btn-success" id="nuevo" title="Crear Egreso">
                    <i class="fa fa-plus"></i> Nuevo Egreso </a>
                <a href="#" class="btn btn-primary" id="proveedores" title="Ver proveedores">
                    <i class="fa fa-truck"></i> Proveedores</a>
            </div>
        </div>
        <div class="col-md-4" style="float: right;" >
            <div class="col-md-8 breadcrumb" style="text-align: center; font-weight: bold">
                Mostrar saldos pendientes
            </div>
            <div class="col-md-4" >
                <input type="checkbox" value="Saldo > 0" id="saldo" data-on-Label="Si">
            </div>
        </div>
    </div>
</div>

<div class="row">
    <div class="col-md-12">
        <div class="col-md-2">
            <b>Buscar por: </b>
            <elm:select name="buscador" from = "${buscadorServ.parmEgrs()}" value="${params.buscador}" optionKey="campo" optionValue="nombre" optionClass="operador"
                        id="buscador_con" class="form-control"/>
        </div>
        <div class="col-md-2">
            <strong>Operación:</strong>
            <span id="selOpt"></span>
        </div>
        <div class="col-md-2">
            <b>Criterio: </b>
            <g:textField name="criterio" value="${params.criterio}" id="criterio_con" class="form-control"/>
        </div>
        <div class="col-md-2">
            <b>    Desde: </b>
            <input name="fechaDesde" id='fechaDesde' type='text' class="form-control fechaD" required="" value="${new Date().format("MM")?.toInteger() - 1}" />
        </div>

        <div class="col-md-2">
            <b>  Hasta: </b>
            <input name="fechaHasta" id='fechaHasta' type='text' class="form-control fechaH" required="" value="${new Date().format("dd-MM-yyyy")}"/>
        </div>

        <div class="btn-group col-md-2" style="margin-top: 20px">
            <a href="#" name="busqueda" class="btn btn-info" id="btnBusqueda" title="Buscar">
                <i class="fa fa-search"></i></a>
            <a href="#" name="limpiarBus" class="btn btn-warning" id="btnLimpiarBusqueda" title="Borrar criterios">
                <i class="fa fa-eraser"></i></a>
        </div>
    </div>
</div>


%{--<div class="row">--}%
%{--    <div class="row-fluid">--}%
%{--        <div style="margin-left: -20px;">--}%
%{--            <div class="col-xs-6">--}%
%{--                <div class="col-xs-3">--}%
%{--                    <b>Buscar por: </b>--}%
%{--                    <elm:select name="buscador" from = "${buscadorServ.parmEgrs()}" value="${params.buscador}"--}%
%{--                                optionKey="campo" optionValue="nombre" optionClass="operador" id="buscador_con"--}%
%{--                                style="width: 120px" class="form-control"/>--}%
%{--                </div>--}%
%{--                <div class="col-xs-3">--}%
%{--                    <strong style="margin-left: 20px;">Operación:</strong>--}%
%{--                    <span id="selOpt"></span>--}%
%{--                </div>--}%
%{--                <div class="col-xs-3">--}%
%{--                    <b style="margin-left: 20px">Criterio: </b>--}%
%{--                    <g:textField name="criterio" style="margin-right: 10px; width: 100%" value="${params.criterio}"--}%
%{--                                 id="criterio_con" class="form-control"/>--}%

%{--                </div>--}%
%{--                <div class="col-xs-3" style="margin-left: -10px;">--}%
%{--                    <b>Ordenado por:</b>--}%
%{--                    <elm:select name="buscador" from="${buscadorServ.parmEgrs()}" value="${params.ordenar}"--}%
%{--                                optionKey="campo" optionValue="nombre" optionClass="operador" id="ordenar_por"--}%
%{--                                style="margin-left:-10px; width: 100%" class="form-control"/>--}%
%{--                </div>--}%
%{--            </div>--}%

%{--            <div class="col-xs-4" style="margin-left: -40px">--}%
%{--            <div class="col-xs-6" style="margin-left: -20px; width: 50%">--}%
%{--                Desde:--}%
%{--                <elm:datepicker name="fechaDesde" title="Fecha desde" id="fd" class="datepicker form-control fechaD"--}%
%{--                                maxDate="new Date()" value="${new Date() - 30}"/>--}%
%{--                <input name="fechaDesde" id='fechaDesde' type='text' class="form-control fechaD" required="" value="${new Date().format("dd-MM-yyyy")}" />--}%
%{--            </div>--}%

%{--            <div class="col-xs-6" style="margin-left: -20px;">--}%
%{--                Hasta:--}%
%{--                <elm:datepicker name="fechaHasta" title="Fecha hasta" class="datepicker form-control fechaH"--}%
%{--                                 value="${new Date()}"/>--}%
%{--                <input name="fechaHasta" id='fechaHasta' type='text' class="form-control fechaH" required="" value="${new Date().format("dd-MM-yyyy")}"/>--}%

%{--            </div>--}%
%{--            </div>--}%

%{--            <div class="btn-group col-xs-1" style="margin-left: -80px; margin-top: 20px; width: 100px">--}%

%{--                <a href="#" name="busqueda" class="btn btn-info" id="btnBusqueda" title="Buscar"--}%
%{--                   style="height: 34px; padding: 9px; width: 36px">--}%
%{--                    <i class="fa fa-search"></i></a>--}%

%{--                <a href="#" name="limpiarBus" class="btn btn-warning" id="btnLimpiarBusqueda"--}%
%{--                   title="Borrar criterios" style="height: 34px; padding: 9px; width: 34px">--}%
%{--                    <i class="fa fa-eraser"></i></a>--}%
%{--            </div>--}%

%{--            <div class="col-xs-2" style="margin-left: -20px; width: 110px;">--}%
%{--                <div class="btn-group col-xs-3 col-md-3" style="margin-left: -10px; margin-top: 20px;">--}%
%{--                    <a href="#" name="busqueda" class="btn btn-success" id="nuevo" title="Crear Egreso">--}%
%{--                        <i class="fa fa-plus"></i></a>--}%
%{--                </div>--}%

%{--                <div class="btn-group col-xs-3 col-md-3" style="margin-left: 10px; margin-top: 20px;">--}%
%{--                    <a href="#" class="btn btn-primary" id="proveedores" title="Ver proveedores">--}%
%{--                        <i class="fa fa-truck"></i></a>--}%
%{--                </div>--}%
%{--            </div>--}%



%{--        </div>--}%
%{--    </div>--}%
%{--</div>--}%

<div style="margin-top: 10px; border-bottom: solid; border-width: 1px; border-color: #C0C0C0"></div>

<div style="margin-top: 20px; min-height: 650px; width: 55%; float: left">
    <table class="table table-bordered table-hover table-condensed">
        <thead>
        <tr>
            <th class="alinear" style="width: 30%">Concepto</th>
            <th class="alinear" style="width: 28%">Proveedor</th>
            <th class="alinear" style="width: 12%">Fecha</th>
            <th class="alinear" style="width: 10%">Valor</th>
            <th class="alinear" style="width: 10%">Saldo</th>
        </tr>
        </thead>
    </table>

    <div class="alert alert-danger hidden" id="mensaje" style="text-align: center">
    </div>

    <div id="tabla">
    </div>
</div>

<div style="margin-top: 20px; min-height: 650px; width: 43%; float: right ">
    <div id="tdPagosEgresos" style="width: 100%">

    </div>

    %{--    <div class="alert alert-danger hidden" id="mensaje" style="text-align: center">--}%
    %{--    </div>--}%

    %{--    <div id="tabla">--}%
    %{--    </div>--}%
</div>



<script type="text/javascript">

    $(function() {
        $("#saldo").checkboxpicker({});
    });

    $('#fechaDesde, #fechaHasta').datetimepicker({
        locale: 'es',
        format: 'DD-MM-YYYY',
        showClose: true,
        icons: {
            close: 'closeText'
        }
    });

    $("#proveedores").click(function () {
        location.href="${createLink(controller: 'proveedor', action: 'list')}?id=" + '${session.empresa.id}' + "&tipo=" + 1
    });

    $(".btnCostos").click(function () {
        costosBancarios();
    });

    $(function () {
        $("#limpiaBuscar").click(function () {
            $("#buscar").val('');
        });
    });

    cargarBusqueda();

    function cargarBusqueda() {
        var desde = $(".fechaD").val();
        var hasta = $(".fechaH").val();
        $.ajax({
            type: "POST",
            url: "${g.createLink(action: 'tablaBuscar')}",
            data: {
                buscador: $("#buscador_con").val(),
                ordenar: $("#ordenar_por").val(),
                criterio: $("#criterio_con").val(),
                operador: $("#oprd").val(),
                desde: desde,
                hasta: hasta,
                saldo: $('#saldo').is(":checked")
            },
            success: function (msg) {
                $("#tabla").html(msg);
            },
            error: function (msg) {
                $("#tabla").html("Ha ocurrido un error");
            }
        });
    }

    $("#btnBusqueda").click(function () {
        cargarBusqueda();
    });

    $("input").keyup(function (ev) {
        if (ev.keyCode === 13) {
            $("#btnBusqueda").click();
        }
    });

    $("#btnLimpiarBusqueda").click(function () {
        $(".fechaD, .fechaH, #criterio_con").val('');
    });

    $("#nuevo").click(function () {
        createEditRowEgreso(null);
    });

    $("#buscador_con").change(function () {
        var opciones = $(this).find("option:selected").attr("class").split(",");
        poneOperadores(opciones);
    });

    function poneOperadores(opcn) {
        var $sel = $("<select name='operador' id='oprd' class='form-control'>");
        for (var i = 0; i < opcn.length; i++) {
            var opt = opcn[i].split(":");
            var $opt = $("<option value='" + opt[0] + "'>" + opt[1] + "</option>");
            $sel.append($opt);
        }
        $("#selOpt").html($sel);
    }

    /* inicializa el select de oprd con la primea opción de busacdor */
    $(document).ready(function () {
        $("#buscador_con").change();
    });

    function createEditRowEgreso(id) {
        var title = id ? "Editar" : "Nueva";
        var data = id ? {id: id} : {};
        $.ajax({
            type: "POST",
            url: "${createLink(controller:'egreso', action:'form_ajax')}",
            data: data,
            success: function (msg) {
                var b = bootbox.dialog({
                    id: "dlgCreateEdit",
                    title: title + " Egreso",
                    message: msg,
                    buttons: {
                        cancelar: {
                            label: "Cancelar",
                            className: "btn-primary",
                            callback: function () {
                            }
                        },
                        guardar: {
                            id: "btnSave",
                            label: "<i class='fa fa-save'></i> Guardar",
                            className: "btn-success",
                            callback: function () {
                                return submitFormNuevoEgreso();
                            } //callback
                        } //guardar
                    } //buttons
                }); //dialog
                setTimeout(function () {
                    b.find(".form-control").first().focus()
                }, 500);
            } //success
        }); //ajax
    } //createEdit

    function submitFormNuevoEgreso() {
        var $form = $("#frmEgreso");
        if ($form.valid()) {
            var cd =  cargarLoader("Guardando...");
            $.ajax({
                type    : "POST",
                url     : '${createLink(action:'save_ajax')}',
                data    : $form.serialize(),
                success : function (msg) {
                    cd.modal("hide");
                    var parts = msg.split("_");
                    if (parts[0] === 'ok') {
                        log(parts[1], "success");
                        cargarBusqueda();
                    } else {
                        log(parts[1], "error");
                    }
                }
            });
        } else {
            return false;
        } //else
    }

    function alicuotaEdit(id) {
        $.ajax({
            type: "POST",
            url: "${createLink(controller:'alicuota', action:'form_ajax')}",
            data: {
                id: id
            },
            success: function (msg) {
                var b = bootbox.dialog({
                    id: "dlgAsignarPerfilxx",
                    title: "Alícuota",
                    message: msg,
                    buttons: {
                        cancelar: {
                            label: "<i class='fa fa-times'></i> Cerrar",
                            className: "btn-primary",
                            callback: function () {
                            }
                        },
                        guardar: {
                            id: "btnSave",
                            label: "<i class='fa fa-save'></i> Guardar",
                            className: "btn-success",
                            callback: function () {
                                return submitFormAlicuota();
                            } //callback
                        }
                    } //buttons
                }); //dialog
                setTimeout(function () {
                    b.find(".form-control").first().focus()
                }, 100);
            } //success
        }); //ajax
    }

    function submitFormAlicuota() {
        var $form = $("#frmAlicuota");
        var $btn = $("#dlgCreateEdit").find("#btnSave");
        if ($form.valid()) {
            $btn.replaceWith(spinner);
            openLoader("Guardando Alicuota");
            $.ajax({
                type: "POST",
                url: $form.attr("action"),
                data: $form.serialize(),
                success: function (msg) {
                    var parts = msg.split("*");
                    log(parts[1], parts[0] === "SUCCESS" ? "success" : "error"); // log(msg, type, title, hide)
                    setTimeout(function () {
                        if (parts[0] === "SUCCESS") {
                            spinner.replaceWith($btn);
                            closeLoader();
                            cargarBusqueda();
                            return false;
                        } else {
                            spinner.replaceWith($btn);
                            return false;
                        }
                    }, 100);
                }
            });
        } else {
            return false;
        } //else
    }

    function eliminarEgreso(id){
        bootbox.dialog({
            title   : "<i class='fa fa-trash fa-2x pull-left text-danger text-shadow'></i> Alerta",
            message : "<p style='font-weight: bold; font-size: 14px'> ¿Está seguro que desea eliminar el Egreso seleccionado?</p>",
            buttons : {
                cancelar : {
                    label     : "Cancelar",
                    className : "btn-primary",
                    callback  : function () {
                    }
                },
                eliminar : {
                    label     : "<i class='fa fa-trash'></i> Eliminar",
                    className : "btn-danger",
                    callback  : function () {
                        var ee = cargarLoader("Eliminando...");
                        $.ajax({
                            type    : "POST",
                            url     : '${createLink(controller:'egreso', action:'delete_ajax')}',
                            data    : {
                                id : id
                            },
                            success : function (msg) {
                                ee.modal("hide");
                                var parts = msg.split("*");
                                log(parts[1], parts[0] === "SUCCESS" ? "success" : "error"); // log(msg, type, title, hide)
                                if (parts[0] === "SUCCESS") {
                                    closeLoader();
                                    cargarBusqueda();
                                }
                            }
                        });
                    }
                }
            }
        });
    }

    function costosBancarios() {
        $.ajax({
            type: "POST",
            url: "${createLink(controller:'egreso', action:'costos_ajax')}",
            data: {

            },
            success: function (msg) {
                var b = bootbox.dialog({
                    id: "dlgCostos",
                    title: "Costo Bancario",
                    class: "modal-sm",
                    message: msg,
                    buttons: {
                        cancelar: {
                            label: "Cancelar",
                            className: "btn-primary",
                            callback: function () {
                            }
                        },
                        guardar: {
                            id: "btnSave",
                            label: "<i class='fa fa-save'></i> Guardar",
                            className: "btn-success",
                            callback: function () {
                                return submitFormCostos();
                            } //callback
                        } //guardar
                    } //buttons
                }); //dialog
                setTimeout(function () {
                    b.find(".form-control").first().focus()
                }, 500);
            } //success
        }); //ajax
    } //createEdit

    function submitFormCostos() {
        var $form = $("#frmBancarios");
        var $btn = $("#dlgCostos").find("#btnSave");
        if ($form.valid()) {
            $btn.replaceWith(spinner);
            openLoader("Guardando...");
            $.ajax({
                type: "POST",
                url: $form.attr("action"),
                data: $form.serialize(),
                success: function (msg) {
                    closeLoader();
                    var parts = msg.split("_");
                    if(parts[0] === 'ok'){
                        log("Costo bancario guardado correctamente " + parts[1],"success");
                        cargarBusqueda();
                    }else{
                        log("Error al guardar el costo bancario","error");
                    }
                }
            });
        } else {
            return false;
        } //else
    }

    function createContextMenu(node) {
        var $tr = $(node);
        var revisado = $tr.hasClass("revisado");
        var saldo = $tr.hasClass("saldo");
        var items = {
            header: {
                label: "Acciones",
                header: true
            }
        };

        var id = $tr.data("id");
        var sz = $tr.data("tam");

        var editar = {
            label: " Editar",
            icon: "fa fa-edit",
            action: function ($element) {
                var id = $element.data("id");
                createEditRowEgreso(id);
            }
        };

        var borrar = {
            label: " Eliminar",
            icon: "fa fa-trash",
            action: function ($element) {
                var id = $element.data("id");
                eliminarEgreso(id);
            }
        };

        var no_edit = {
            label: " Ya está revisado",
            icon: "fa fa-check",
            header: true
        };

        if(!revisado){
            items.editar = editar;
        } else {
            if(saldo){
                items.editar = editar;
            }
            items.no_edit = no_edit;
        }

        if(sz === 0){
            items.borrar = borrar;
        }

        return items
    }

</script>
</body>
</html>