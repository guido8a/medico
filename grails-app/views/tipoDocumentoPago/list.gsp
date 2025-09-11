<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <title>Formas de Pago</title>
</head>
<body>

<!-- botones -->
<div class="btn-toolbar toolbar" style="margin-top: 10px">
    <div class="btn-group">
        <g:link class="btn btn-default col-md-2" style="width: 100px;" controller="inicio" action="parametrosContabilidad"><i class="fa fa-arrow-left"></i> Regresar</g:link>
        <g:link action="form" class="btn btn-info btnCrear">
            <i class="fa fa-file"></i> Nueva forma de pago
        </g:link>
    </div>
</div>

<div style="width: 50%">
    <table class="table table-condensed table-bordered table-striped table-hover">
        <thead>
        <tr>
            <th style="width: 75%">Descripción</th>
            <th style="width: 25%">Acciones</th>
        </tr>
        </thead>
        <tbody>
        <g:if test="${formaDePagoInstanceList.size() > 0}">
            <g:each in="${formaDePagoInstanceList}" status="i" var="formaDePagoInstance">
                <tr data-id="${formaDePagoInstance.id}" style="text-align: center">
                    <td>${fieldValue(bean: formaDePagoInstance, field: "descripcion")}</td>
                    <td>
                        <a href="#" data-id="${formaDePagoInstance.id}" class="btn btn-success btn-sm btn-edit btn-ajax" title="Editar">
                            <i class="fa fa-edit"></i>
                        </a>
                        <a href="#" data-id="${formaDePagoInstance.id}" class="btn btn-danger btn-sm btn-delete btn-ajax" title="Eliminar">
                            <i class="fa fa-trash"></i>
                        </a>
                    </td>
                </tr>
            </g:each>
        </g:if>
        <g:else>
            <tr style="text-align: center">
                <td class="alert alert-warning" colspan="3"><i class="fa fa-exclamation-triangle fa-2x text-info"></i> <strong style="font-size: 16px"> No existen registros </strong></td>
            </tr>
        </g:else>
        </tbody>
    </table>
</div>

<script type="text/javascript">
    var id = null;

    function submitForm() {
        var $form = $("#frmFormaDePago");
        var $btn = $("#dlgCreateEdit").find("#btnSave");
        if ($form.valid()) {
            $btn.replaceWith(spinner);
            openLoader("Guardando...");
            $.ajax({
                type    : "POST",
                url     : $form.attr("action"),
                data    : $form.serialize(),
                success : function (msg) {
                    closeLoader();
                    if (msg === "ok") {
                        log("Forma de pago guardado correctamente","success");
                        setTimeout(function () {
                            location.reload();
                        }, 1000);
                    } else {
                        log("Error al guardar la forma de pago","error");
                        return false;
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
            message : "<p>¿Está seguro que desea eliminar la Forma de Pago seleccionado? Esta acción no se puede deshacer.</p>",
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
                        openLoader("Eliminando...");
                        $.ajax({
                            type    : "POST",
                            url     : '${createLink(action:'delete_ajax')}',
                            data    : {
                                id : itemId
                            },
                            success : function (msg) {
                                closeLoader();
                                if (msg === "ok") {
                                    log("Forma de pago borrado correctamente","success");
                                    setTimeout(function () {
                                        location.reload();
                                    }, 1000);
                                } else {
                                    log("Error al borrar la forma de pago","error");
                                    return false;
                                }
                            }
                        });
                    }
                }
            }
        });
    }
    function createEditRow(id) {
        var title = id ? "Editar" : "Crear";
        var data = id ? { id: id } : {};
        $.ajax({
            type    : "POST",
            url     : "${createLink(action:'form_ajax')}",
            data    : data,
            success : function (msg) {
                var b = bootbox.dialog({
                    id      : "dlgCreateEdit",
                    title   : title + " Forma De Pago",
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
                setTimeout(function () {
                    b.find(".form-control").not(".datepicker").first().focus()
                }, 500);
            } //success
        }); //ajax
    } //createEdit

    $(".btnCrear").click(function() {
        createEditRow();
        return false;
    });

    $(".btn-edit").click(function () {
        var id = $(this).data("id");
        createEditRow(id);
    });
    $(".btn-delete").click(function () {
        var id = $(this).data("id");
        deleteRow(id);
    });

</script>

</body>
</html>
