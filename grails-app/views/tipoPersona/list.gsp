<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <title>Lista de Tipos de personas</title>
</head>
<body>

<!-- botones -->
<div class="btn-toolbar toolbar" style="margin-bottom: 15px; margin-top: 10px">
    <div class="btn-group">
        <g:link controller="persona" action="list" class="btn btn-primary">
            <i class="fa fa-arrow-left"></i> Regresar
        </g:link>
        <a href="#" class="btn btn-success btnNuevoTipo">
            <i class="fa fa-file"></i>
            Nuevo tipo
        </a>
    </div>
</div>

<div style="overflow: hidden">
    <fieldset class="borde" style="border-radius: 4px">
        <div role="main" style="margin-top: 10px;">
            <table class="table table-bordered table-striped table-condensed table-hover">
                <thead>
                <tr>
                    <th style="width: 20%">Código</th>
                    <th style="width: 70%">Descripción</th>
                    <th style="width: 10%">Acciones</th>
                </tr>
                </thead>
            </table>
        </div>

        <div class="" style="width: 99.7%;height: 600px; overflow-y: auto;float: right; margin-top: -20px">
            <table class="table-bordered table-striped table-condensed table-hover" style="width: 100%">
                <tbody>
                <g:if test="${tipos.size() > 0}">
                    <g:each in="${tipos}" status="i" var="tipo">
                        <tr data-id="${tipo?.id}">
                            <td style="width: 20%">${tipo.codigo}</td>
                            <td style="width: 70%">${tipo.descripcion}</td>
                            <td style="width: 10%; text-align: center">
                                <a href="#" class="btn btn-xs btn-success btnEditarTipo" data-id="${tipo?.id}" title="Editar tipo">
                                    <i class="fas fa-edit"></i>
                                </a>
                                <a href="#" class="btn btn-xs btn-danger btnEliminarTipo" data-id="${tipo?.id}" title="Eliminar tipo">
                                    <i class="fas fa-trash"></i>
                                </a>
                            </td>
                        </tr>
                    </g:each>
                </g:if>
                <g:else>
                    <div class="alert alert-info" style="text-align: center; font-size: 14px; font-weight: bold"><i class="fa fa-exclamation-triangle fa-2x text-info"></i> No existen registros</div>
                </g:else>
                </tbody>
            </table>
        </div>
    </fieldset>
</div>

<script type="text/javascript">
    var di;

    $(".btnNuevoTipo").click(function () {
        createEditRow();
    });

    $(".btnEditarTipo").click(function () {
        var id = $(this).data("id");
        createEditRow(id);
    });

    $(".btnEliminarTipo").click(function () {
        var id = $(this).data("id");
        deleteRow(id);
    });

    function createEditRow(id) {
        var title = id ? "Editar " : "Crear ";
        var data = id ? {id : id}: {};

        $.ajax({
            type    : "POST",
            url: "${createLink(controller: 'tipoPersona',  action:'form_ajax')}",
            data    : data,
            success : function (msg) {
                var b = bootbox.dialog({
                    id      : "dlgCreateEdit",
                    title   : title + " Tipo",
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
                                return submitFormTipo();
                            } //callback
                        } //guardar
                    } //buttons
                }); //dialog
            } //success
        }); //ajax
    } //createEdit

    function submitFormTipo() {
        var $form = $("#frmTipo");
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
                        location.reload()
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

    function deleteRow(itemId) {
        bootbox.dialog({
            title   : "Alerta",
            message : "<i class='fa fa-trash fa-2x pull-left text-danger text-shadow'></i><p style='font-weight: bold'> Está seguro que desea eliminar este tipo? Esta acción no se puede deshacer.</p>",
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
                            url     : '${createLink(controller: 'tipoPersona', action:'borrarTipo_ajax')}',
                            data    : {
                                id : itemId
                            },
                            success : function (msg) {
                                v.modal("hide");
                                var parts = msg.split("_");
                                if(parts[0] === 'ok'){
                                    log(parts[1],"success");
                                    location.reload()
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
