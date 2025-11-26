<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <title>Gestores Contables</title>
</head>

<body>
<div class="row">
    <div class="col-md-12">
        <div class="col-md-3 btn-group">
            <a href="#" class="btn btn-primary" id="btnRegresarProcesos">
                <i class="fa fa-arrow-left"></i> Regresar
            </a>
            <g:link class="btn btn-success" action="formGestor">
                <i class="fa fa-file"></i> Nuevo Gestor
            </g:link>
        </div>

        <div class="col-md-6" style="margin-left: 20px;">
            <label class="col-md-1">
                Buscar
            </label>
            <div class="col-md-7">
                <input id="buscar" type="search" class="form-control" value="${session.buscar}">
            </div>
            <div class="col-md-4">
                <a href="#" id="busqueda" class="btn btn-info btnBusqueda btn-ajax" title="Buscar">
                    <i  class="fa fa-search"></i>
                </a>
                <a href="#" id="btnLimpiarBusqueda" title="Limpiar Búsqueda" class="btn btn-warning">
                    <i  class="fa fa-eraser"></i>
                </a>
            </div>
        </div>
        <g:if test="${!gestorIniciales}">
            <div class="col-md-3">
                <a href="#" class="btn btn-info" id="btnInicial">
                    <i class="fa fa-check"></i> Crear gestor de saldos iniciales
                </a>
            </div>
        </g:if>
    </div>

    <div class="col-md-12">
        <div style="margin-top: 10px; min-height: 350px">
            <table class="table table-bordered table-hover table-striped table-condensed" style="width: 100%">
                <thead>
                <tr>
                    <th class="alinear" style="width: 20%">Proceso</th>
                    <th class="alinear" style="width: 50%">Nombre</th>
                    <th class="alinear" style="width: 15%">Estado</th>
                    <th class="alinear" style="width: 15%">Tipo</th>
                </tr>
                </thead>
            </table>

            <div id="bandeja">
            </div>
        </div>

        %{--        <div class="modal fade " id="dialog" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">--}%
        %{--            <div class="modal-dialog modal-lg">--}%
        %{--                <div class="modal-content">--}%
        %{--                    <div class="modal-header">--}%
        %{--                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>--}%
        %{--                        Problema y Solución..--}%
        %{--                    </div>--}%

        %{--                    <div class="modal-body" id="dialog-body" style="padding: 15px">--}%

        %{--                    </div>--}%

        %{--                    <div class="modal-footer">--}%
        %{--                        <button type="button" class="btn btn-primary" data-dismiss="modal">Cerrar</button>--}%
        %{--                    </div>--}%
        %{--                </div><!-- /.modal-content -->--}%
        %{--            </div><!-- /.modal-dialog -->--}%
        %{--        </div>--}%
    </div>
</div>

<script type="text/javascript">

    $("#btnRegresarProcesos").click(function(){
        location.href="${createLink(controller: 'inicio', action: 'parametrosContabilidad')}"
    });

    $("#btnLimpiarBusqueda").click(function(){
        $("#buscar").val('');
        cargarBusqueda();
    });

    $("#btnInicial").click(function () {
        bootbox.confirm("<i class='fa fa-check fa-3x pull-left text-warning text-shadow'></i> Está seguro de crear un gestor de saldos iniciales?", function (result) {
            if (result) {
                openLoader("Creando...");
                $.ajax({
                    type: 'POST',
                    url:'${createLink(controller: 'gestor', action: 'crearGestorSaldoInicial_ajax')}',
                    data:{

                    },
                    success: function (msg){
                        closeLoader();
                        if(msg === 'OK'){
                            log("Gestor de Saldos Iniciales creado correctamente", "success");
                            setTimeout(function () {
                                location.reload(true);
                            }, 1500);
                        }else{
                            log("Error al crear el gestor de saldos iniciales", "error");
                        }
                    }
                });
            }
        });
    });

    cargarBusqueda();

    function cargarBusqueda() {
        $("#bandeja").html("").append($("<div style='width:100%; text-align: center;'/>").append(spinnerSquare64));
        var buscar = $("#buscar").val();
        var datos = "buscar=" + buscar;

        $.ajax({
            type: "POST",
            url: "${g.createLink(action: 'tablaBuscarGstr')}",
            data: datos,
            success: function (msg) {
                $("#bandeja").html(msg);
            },
            error: function (msg) {
                $("#bandeja").html("Ha ocurrido un error");
            }
        });
    }

    $(".btnBusqueda").click(function () {
        cargarBusqueda();
    });

    $("input").keyup(function (ev) {
        if (ev.keyCode === 13) {
            $(".btnBusqueda").click();
        }
    });

    function createContextMenu(node) {
        var $tr = $(node);

        var items = {
            header: {
                label: "Acciones",
                header: true
            }
        };

        var etdo = $tr.data("ed");
        var id = $tr.data("id");

        var editar = {
            label: " Editar",
            icon: "fa fa-file-text-o",
            action: function () {
                location.href = '${createLink(action: "formGestor")}?id=' + id;
            }
        };

        var ver = {
            label: " Ver gestor",
            icon: "fa fa-search-plus",
            action: function () {
                location.href = '${createLink(action: "formGestor")}?id=' + id;
            }
        };

        var copiar = {
            label: " Copiar gestor",
            icon: "fa fa-copy",
            action: function () {
                var b = bootbox.dialog({
                    id: "dlgCopiarGestor",
                    title: "Copiar Gestor",
                    message:  "<label>Nombre</label> </br> <input name='copiName' id='copiado' style='height: 40px;' class='form-control'/>",
                    buttons: {
                        cancelar: {
                            label: "<i class='fa fa-times'></i> Cancelar",
                            className: "btn-primary",
                            callback: function () {
                            }
                        },
                        aceptar: {
                            label: "<i class='fa fa-times'></i> Aceptar",
                            className: "btn-success",
                            callback: function () {
                                var cp = $("#copiado").val();
                                $.ajax({
                                    type: 'POST',
                                    url: '${createLink(controller: 'gestor', action: 'copiarGestor_ajax')}',
                                    data:{
                                        id: id,
                                        nombre:  cp
                                    },
                                    success: function(msg){
                                        if(msg == 'ok'){
                                            bootbox.hideAll();
                                            log("Gestor copiado correctamente","success");
                                            setTimeout(function () {
                                                location.reload(true);
                                            }, 1500);
                                        }else{
                                            log("Error al copiar el gestor ","error")
                                        }

                                    }
                                })
                            }
                        }
                    } //buttons
                }); //dialog
            }
        };

        // if(etdo !== 'R') {
        //     items.editar = editar;
        // }
        items.ver = ver;
        items.copiar = copiar;

        return items
    }

</script>
</body>
</html>