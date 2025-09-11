<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <title>Tipo de Comprobantes</title>
</head>
<body>

<!-- botones -->
<div class="btn-toolbar toolbar" style="margin-top: 10px">
    <div class="btn-group">
        <g:link class="btn btn-default col-md-2" style="width: 100px;" controller="inicio" action="parametrosContabilidad"><i class="fa fa-arrow-left"></i> Regresar</g:link>
        <g:link action="form" class="btn btn-info btnCrear">
            <i class="fa fa-file"></i> Nuevo tipo de comprobante
        </g:link>
    </div>
</div>

<div style="width: 60%">
    <table class="table table-condensed table-bordered table-striped table-hover">
        <thead>
        <tr>
            <th style="width: 15%">Código</th>
            <th style="width: 70%">Descripción</th>
            <th style="width: 15%">Acciones</th>
        </tr>
        </thead>
        <tbody>
        <g:if test="${tipoComprobanteInstanceList.size() > 0}">
            <g:each in="${tipoComprobanteInstanceList}" status="i" var="tipoComprobanteInstance">
                <tr data-id="${tipoComprobanteInstance.id}">
                    <td>${fieldValue(bean: tipoComprobanteInstance, field: "codigo")}</td>
                    <td>${fieldValue(bean: tipoComprobanteInstance, field: "descripcion")}</td>
                    <td style="text-align: center">
                        <a href="#" data-id="${tipoComprobanteInstance.id}" class="btn btn-success btn-sm btn-edit btn-ajax" title="Editar">
                            <i class="fa fa-edit"></i>
                        </a>
                        <a href="#" data-id="${tipoComprobanteInstance.id}" class="btn btn-danger btn-sm btn-delete btn-ajax" title="Eliminar">
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
        var $form = $("#frmTipoComprobante");
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
                        log("Tipo de comprobante guardado correctamente","success");
                        setTimeout(function () {
                            location.reload();
                        }, 1000);
                    } else {
                        if(msg === 'er'){
                            bootbox.alert("Código ya existente");
                        }else{
                            log("Error al guardar el tipo de comprobante","error");
                            return false;
                        }
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
            message : "<p>¿Está seguro que desea eliminar el Tipo de Comprobante seleccionado? Esta acción no se puede deshacer.</p>",
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
                                    log("Tipo de comprobante borrado correctamente","success");
                                    setTimeout(function () {
                                        location.reload();
                                    }, 1000);
                                } else {
                                    log("Error al borrar el tipo de comprobante","error");
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
                    title   : title + " Tipo de Comprobante",
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
