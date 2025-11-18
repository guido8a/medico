<!doctype html>
<html>
<head>
    <meta name="layout" content="main">
    <title>
        Lista de Proveedores
    </title>
</head>
<body>

<div class="row" style="margin-bottom: 10px">
    <div class="col-md-6 btn-group" role="navigation">
        <g:if test="${tipo == '1'}">
            <g:link class="btn btn-primary col-md-2" controller="egreso" action="egresos"><i class="fa fa-arrow-left"></i> Regresar</g:link>
        </g:if>
        <g:else>
            <g:link class="btn btn-primary col-md-2" controller="empresa" action="list"><i class="fa fa-arrow-left"></i> Regresar</g:link>
        </g:else>
        <a href="#" class="btn btn-success btnNuevoProveedor">
            <i class="fa fa-file"></i>
            Nuevo proveedor
        </a>
    </div>
</div>

<div style="overflow: hidden">
    <fieldset class="borde" style="border-radius: 4px; margin-bottom: 10px">
        <div class="row-fluid" style="margin-left: 10px">
            <span class="grupo">
                <span class="col-md-2">
                    <label class="control-label text-info">Buscar Por</label>
                    <g:select name="buscarPor" class="buscarPor col-md-12 form-control" from="${[1: 'RUC', 2: 'Nombre']}" optionKey="key"
                              optionValue="value"/>
                </span>
                <span class="col-md-2">
                    <label class="control-label text-info">Criterio</label>
                    <g:textField name="criterio" id="criterio" class="form-control"/>
                </span>
            </span>
            <div class="col-md-1" style="margin-top: 20px">
                <button class="btn btn-info" id="btnBuscarProveedor"><i class="fa fa-search"></i></button>
            </div>
            <div class="col-md-1" style="margin-top: 20px">
                <button class="btn btn-warning" id="btnLimpiar" title="Limpiar Búsqueda"><i class="fa fa-eraser"></i></button>
            </div>
        </div>
    </fieldset>

    <fieldset class="borde" style="border-radius: 4px">
        <div id="divTablaProveedores" >
        </div>
    </fieldset>
</div>

<script type="text/javascript">

    $("#btnLimpiar").click(function () {
        $("#buscarPor").val(1);
        $("#criterio").val('');
        cargarTablaProveedor();
    });

    $("#btnBuscarProveedor").click(function (){
        cargarTablaProveedor();
    });

    $(".btnNuevoProveedor").click(function () {
        createEditProveedor();
    });

    cargarTablaProveedor();

    function cargarTablaProveedor() {
        var buscarPor = $("#buscarPor option:selected").val();
        var criterio = $("#criterio").val();
        var d = cargarLoader("Cargando...");
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'proveedor', action: 'tablaProveedor_ajax')}',
            data:{
                buscarPor: buscarPor,
                criterio: criterio,
                empresa: '${empresa?.id}'
            },
            success: function (msg){
                d.modal("hide");
                $("#divTablaProveedores").html(msg)
            }
        })
    }

    function createEditProveedor(id) {
        var title = id ? "Editar " : "Crear ";
        var data = id ? {id : id}: {};

        $.ajax({
            type    : "POST",
            url: "${createLink(action:'form_ajax')}",
            data    : data,
            success : function (msg) {
                var b = bootbox.dialog({
                    id      : "dlgCreateEdit",
                    title   : title + " Proveedor",
                    class: "modal-lg",
                    message : msg,
                    buttons : {
                        cancelar : {
                            label     : "Cancelar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        },
                        guardar  : {
                            id        : "btnSave",
                            label     : "<i class='fa fa-save'></i> Guardar",
                            className : "btn-success",
                            callback  : function () {
                                return submitFormProveedor();
                            } //callback
                        } //guardar
                    } //buttons
                }); //dialog
            } //success
        }); //ajax
    } //createEdit

    function submitFormProveedor() {
        var $form = $("#frmProveedor");
        if ($form.valid()) {
            var data = $form.serialize();
            var dialog = cargarLoader("Guardando...");
            $.ajax({
                type    : "POST",
                url     : $form.attr("action"),
                data    : data,
                success : function (msg) {
                    dialog.modal('hide');
                    var parts = msg.split("_");
                    if(parts[0] === 'ok'){
                        log(parts[1], "success");
                        cargarTablaProveedor();
                    }else{
                        bootbox.alert('<i class="fa fa-exclamation-triangle text-danger fa-3x"></i> ' + '<strong style="font-size: 14px">' + parts[1] + '</strong>');
                        return false;
                    }
                }
            });
        } else {
            return false;
        }
    }

    function deleteProveedor(itemId) {
        bootbox.dialog({
            title   : " <i class='fa fa-trash fa-2x pull-left text-danger text-shadow'></i> Alerta",
            message : "<p style='font-weight: bold'> Está seguro que desea eliminar este proveedor? Esta acción no se puede deshacer.</p>",
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
                        var v = cargarLoader("Eliminando...");
                        $.ajax({
                            type    : "POST",
                            url     : '${createLink(action:'delete_ajax')}',
                            data    : {
                                id : itemId
                            },
                            success : function (msg) {
                                v.modal("hide");
                                var parts = msg.split("_");
                                if(parts[0] === 'ok'){
                                    log(parts[1],"success");
                                    cargarTablaProveedor();
                                }else{
                                    log(parts[1],"error")
                                }
                            }
                        });
                    }
                }
            }
        });
    }

</script>
</body>
</html>
