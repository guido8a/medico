<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <title>Lista de Años</title>
</head>
<body>

<!-- botones -->
<div class="btn-toolbar toolbar row" style="margin-top: 10px">
    <div class="btn-group col-md-6">
        <g:link class="btn btn-default col-md-2" controller="inicio" action="parametrosContabilidad"><i class="fa fa-arrow-left"></i> Regresar</g:link>
        <g:link action="form" class="btn btn-info btnCrear">
            <i class="fa fa-file"></i> Nuevo Año
        </g:link>
    </div>
</div>

<div style="width: 70%">
    <table class="table table-condensed table-bordered table-striped table-hover">
        <thead>
        <tr>
            <th style="width: 15%">Código</th>
            <th style="width: 25%">Año</th>
            <th style="width: 30%">Sueldo</th>
            <th style="width: 15%">Acciones</th>
        </tr>
        </thead>
        <tbody>
        <g:if test="${anioInstanceList.size() > 0}">
            <g:each in="${anioInstanceList}" status="i" var="anioInstance">
                <tr data-id="${anioInstance.id}" style="text-align: center">
                    <td>${anioInstance?.id}</td>
                    <td>${fieldValue(bean: anioInstance, field: "anio")}</td>
                    <td><g:formatNumber number="${anioInstance?.sueldoBasico}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/></td>
                    <td>
                        <a href="#" data-id="${anioInstance.id}" class="btn btn-success btn-sm btn-edit btn-ajax" title="Editar">
                            <i class="fa fa-edit"></i>
                        </a>
                        <a href="#" data-id="${anioInstance.id}" class="btn btn-danger btn-sm btn-delete btn-ajax" title="Eliminar">
                            <i class="fa fa-trash"></i>
                        </a>
                    </td>
                </tr>
            </g:each>
        </g:if>
        <g:else>
            <tr style="text-align: center">
                <td class="alert alert-warning" colspan="4"><i class="fa fa-exclamation-triangle fa-2x text-info"></i> <strong style="font-size: 16px"> No existen registros </strong></td>
            </tr>
        </g:else>
        </tbody>
    </table>
</div>


<script type="text/javascript">
    var id = null;
    function submitForm() {
        var $form = $("#frmAnio");
        if ($form.valid()) {
            openLoader("Guardando...");
            $.ajax({
                type    : "POST",
                url     : '${createLink(action:'save_ajax')}',
                data    : $form.serialize(),
                success : function (msg) {
                    closeLoader();
                    if (msg === "ok") {
                        log("Año guardado correctamente","success");
                        setTimeout(function () {
                            location.reload();
                        }, 1000);
                    } else {
                        if(msg === 'er'){
                            bootbox.alert("Año ya existente");
                        }else{
                            log("Error al guardar el año","error");
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
            message : "<p>¿Está seguro que desea eliminar el Año seleccionado? Esta acción no se puede deshacer.</p>",
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
                                    log("Año borrado correctamente", "success");
                                    setTimeout(function () {
                                        location.reload();
                                    }, 800);
                                }else{
                                    log("Error al borrar el año", "error")
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
                    title   : title + " Año",
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
