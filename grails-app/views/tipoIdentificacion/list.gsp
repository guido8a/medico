<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <title>Tipos de Identificación</title>
</head>
<body>

<!-- botones -->
<div class="btn-toolbar toolbar" style="margin-top: 10px">
    <div class="btn-group">
        <g:link class="btn btn-default col-md-2" style="width: 100px;" controller="inicio" action="parametrosContabilidad"><i class="fa fa-arrow-left"></i> Regresar</g:link>
%{--        <g:link action="form" class="btn btn-info btnCrear">--}%
%{--            <i class="fa fa-file"></i> Nuevo Tipo--}%
%{--        </g:link>--}%
    </div>
</div>

<table class="table table-condensed table-bordered table-striped" style="width: 70%">
    <thead>
    <tr>
        <th style="width: 15%">Código</th>
        <th style="width: 45%">Descripción</th>
        <th style="width: 20%">Código SRI</th>
%{--        <th style="width: 20%">Acciones</th>--}%
    </tr>
    </thead>
    <tbody>
    <g:if test="${tipoIdentificacionInstanceList.size() > 0}">
        <g:each in="${tipoIdentificacionInstanceList}" status="i" var="tipoIdentificacionInstance">
            <tr data-id="${tipoIdentificacionInstance.id}">
                <td>${fieldValue(bean: tipoIdentificacionInstance, field: "codigo")}</td>
                <td>${fieldValue(bean: tipoIdentificacionInstance, field: "descripcion")}</td>
                <td>${fieldValue(bean: tipoIdentificacionInstance, field: "codigoSri")}</td>
%{--                <td style="text-align: center">--}%
%{--                    <a href="#" data-id="${tipoIdentificacionInstance.id}" class="btn btn-success btn-xs btn-edit btn-ajax" title="Editar">--}%
%{--                        <i class="fa fa-edit"></i>--}%
%{--                    </a>--}%
%{--                    <a href="#" data-id="${tipoIdentificacionInstance.id}" class="btn btn-danger btn-xs btn-delete btn-ajax" title="Eliminar">--}%
%{--                        <i class="fa fa-trash"></i>--}%
%{--                    </a>--}%
%{--                </td>--}%
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

<script type="text/javascript">
    var id = null;
    function submitForm() {
        var $form = $("#frmTipoIdentificacion");
        var $btn = $("#dlgCreateEdit").find("#btnSave");
        if ($form.valid()) {
            $btn.replaceWith(spinner);
            $.ajax({
                type    : "POST",
                url     : '${createLink(action:'save_ajax')}',
                data    : $form.serialize(),
                success : function (msg) {
                    if (msg === "ok") {
                        log("Tipo de identificación guardado correctamente","success");
                        setTimeout(function () {
                            location.reload();
                        }, 1000);
                    } else {
                        if(msg === 'er'){
                            bootbox.alert("Código ya existente");
                        }else{
                            log("Error al guardar el tipo de identificación","error");
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
            title   : "<i class='fa fa-trash fa-3x pull-left text-danger text-shadow'></i> Alerta",
            message : "<p>¿Está seguro que desea eliminar el Tipo de Identificación seleccionado? Esta acción no se puede deshacer.</p>",
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
                        $.ajax({
                            type    : "POST",
                            url     : '${createLink(action:'delete_ajax')}',
                            data    : {
                                id : itemId
                            },
                            success : function (msg) {
                                if (msg === "ok") {
                                    log("Tipo de Identificación borrada correctamente","success");
                                    setTimeout(function () {
                                        location.reload();
                                    }, 1000);
                                } else {
                                    log("Error al borrar el Tipo de Identificación","error");
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
                    title   : title + " Tipo de Identificación",
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
                    b.find(".form-control").first().focus()
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
