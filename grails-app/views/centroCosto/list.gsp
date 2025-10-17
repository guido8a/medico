<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <title>Lista de Centro de Costos</title>
</head>
<body>

<!-- botones -->
<div class="btn-toolbar toolbar">
    <div class="btn-group">
        <g:link controller="inicio" action="parametrosContabilidad" class="btn btn-info btnRegresar">
            <i class="fa fa-arrow-left"></i> Parámetros
        </g:link>
        <a href="#" class="btn btn-success" id="btnCrearCentroCostos">
            <i class="fa fa-file"></i> Crear centro
        </a>
    </div>
</div>

<div style="width: 60%">
    <table class="table table-condensed table-bordered table-striped table-hover">
        <thead>
        <tr>
            <th style="width: 100px">Código</th>
            <th style="width: 500px">Nombre</th>
            <th style="width: 100px">Acciones</th>
        </tr>
        </thead>
        <tbody>
            <g:each in="${centroCostoInstanceList}" status="i" var="centroCostoInstance">
                <g:if test="${centroCostoInstance.empresa.id == session.empresa.id}">
                    <tr data-id="${centroCostoInstance.id}">
                        <td>${centroCostoInstance?.codigo}</td>
                        <td>${centroCostoInstance?.nombre}</td>
                        <td style="text-align: center">
                            <a href="#" data-id="${centroCostoInstance.id}" class="btn btn-success btn-xs btn-edit" title="Editar">
                                <i class="fa fa-edit"></i>
                            </a>
                            <a href="#" data-id="${centroCostoInstance.id}" class="btn btn-danger btn-xs btn-delete" title="Eliminar">
                                <i class="fa fa-trash"></i>
                            </a>
                        </td>
                    </tr>
                </g:if>
            </g:each>
        </tbody>
    </table>
</div>

<script type="text/javascript">
    var id = null;

    $("#btnCrearCentroCostos").click(function () {
        createEditRow()
    });

    $(".btn-edit").click(function () {
        var id = $(this).data("id");
        createEditRow(id);
    });
    $(".btn-delete").click(function () {
        var id = $(this).data("id");
        deleteRow(id);
    });

    function createEditRow(id) {
        var title = id ? "Editar" : "Crear";
        var data = id ? { id: id } : {};
        $.ajax({
            type    : "POST",
            url     : "${createLink(action:'form_ajax')}",
            data    : data,
            success : function (msg) {
                var b = bootbox.dialog({
                    id      : "dlgCreateEditCC",
                    title   : title + " Centro de Costos",
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
                                return submitForm();
                            } //callback
                        } //guardar
                    } //buttons
                }); //dialog
            } //success
        }); //ajax
    } //createEdit

    function submitForm() {
        var $form = $("#frmCentroCosto");
        if ($form.valid()) {
           var a = cargarLoader("Grabando");
            $.ajax({
                type    : "POST",
                url     : $form.attr("action"),
                data    : $form.serialize(),
                success : function (msg) {
                    a.modal("hide");
                    var parts = msg.split("_");
                    if (parts[0] === "ok") {
                        log(parts[1], "success");
                        setTimeout(function () {
                            location.reload();
                        }, 1000);
                    } else {
                        log(parts[1], "error")
                    }
                }
            });
        } else {
            return false;
        } //else
    }
    function deleteRow(itemId) {
        bootbox.dialog({
            title   : "<i class='fa fa-trash fa-2x pull-left text-danger text-shadow'></i> Alerta",
            message : "<p>¿Está seguro que desea eliminar el Centro de Costos seleccionado?</p>",
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
                        var b = cargarLoader("Eliminando");
                        $.ajax({
                            type    : "POST",
                            url     : '${createLink(action:'delete_ajax')}',
                            data    : {
                                id : itemId
                            },
                            success : function (msg) {
                                b.modal("hide");
                                var parts = msg.split("_");
                                if (parts[0] === "ok") {
                                    log(parts[1], "success");
                                    setTimeout(function () {
                                        location.reload();
                                    }, 1000);
                                } else {
                                    log(parts[1], "error")
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