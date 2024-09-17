<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <title>Exámenes médicos</title>
</head>

<body>

<!-- botones -->
<div class="btn-toolbar toolbar" style="margin-top: 10px">
    <div class="btn-group">
        <g:link controller="inicio" action="parametros" class="btn btn-primary">
            <i class="fa fa-arrow-left"></i> Regresar
        </g:link>
    </div>

    <div class="btn-group">
        <g:link action="form" class="btn btn-success btnCrear">
            <i class="fa fa-clipboard-list"></i> Nuevo Examen
        </g:link>
    </div>

    <span class="col-md-3" style="text-align: right; margin-top: 10px">
        <label class="control-label text-info">Criterio de búsqueda</label>
    </span>
    <span class="col-md-2">
        <g:textField name="criterio" id="criterio" class="form-control"/>
    </span>

    <div class="col-md-1">
        <button class="btn btn-info" id="btnBuscarExamen"><i class="fa fa-search"></i>Buscar</button>
    </div>

    <div class="col-md-1">
        <button class="btn btn-warning" id="btnLimpiar" title="Limpiar Búsqueda"><i class="fa fa-eraser"></i>Limpiar
        </button>
    </div>

</div>


<div style="overflow: hidden">
    <fieldset class="borde" style="border-radius: 4px">
        <div id="divTablaExamenes">
        </div>
    </fieldset>
</div>

<script type="text/javascript">
    var id = null;

    $("#btnLimpiar").click(function () {
        $("#criterio").val('');
        cargarTablaExamenes();
    });

    $("#btnBuscarExamen").click(function () {
        cargarTablaExamenes();
    });

    $("#criterio").keydown(function (ev) {
        if (ev.keyCode === 13) {
            cargarTablaExamenes();
            return false;
        }
        return true;
    });

    cargarTablaExamenes();

    function cargarTablaExamenes() {
        var d = cargarLoader("Cargando...");
        var buscarPor = $("#buscarPor option:selected").val();
        var criterio = $("#criterio").val();
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'examen', action: 'tablaExamen_ajax')}',
            data: {
                criterio: criterio
            },
            success: function (msg) {
                d.modal("hide");
                $("#divTablaExamenes").html(msg)
            }
        })
    }

    function submitForm() {
        var $form = $("#frmExamen");
        if ($form.valid()) {
            $.ajax({
                type: "POST",
                url: '${createLink(controller: 'examen', action:'save_ajax')}',
                data: $form.serialize(),
                success: function (msg) {
                    var parts = msg.split("_");
                    if (parts[0] === 'ok') {
                        log(parts[1], "success");
                        cargarTablaExamenes();
                    } else {
                        bootbox.alert('<i class="fa fa-exclamation-triangle text-danger fa-3x"></i> ' + '<strong style="font-size: 14px">' + parts[1] + '</strong>');
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
            title: "Alerta",
            message: "<i class='fa fa-trash fa-2x pull-left text-danger text-shadow'></i><p style='font-weight: bold; font-size: 14px'> ¿Está seguro que desea eliminar el examen seleccionado?.</p>",
            buttons: {
                cancelar: {
                    label: "Cancelar",
                    className: "btn-primary",
                    callback: function () {
                    }
                },
                eliminar: {
                    label: "<i class='fa fa-trash'></i> Eliminar",
                    className: "btn-danger",
                    callback: function () {
                        $.ajax({
                            type: "POST",
                            url: '${createLink(controller: 'examen', action:'delete_ajax')}',
                            data: {
                                id: itemId
                            },
                            success: function (msg) {
                                var parts = msg.split("_");
                                if (parts[0] === 'ok') {
                                    log(parts[1], "success");
                                    cargarTablaExamenes();
                                } else {
                                    bootbox.alert('<i class="fa fa-exclamation-triangle text-danger fa-3x"></i> ' + '<strong style="font-size: 14px">' + parts[1] + '</strong>');
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
        var data = id ? {id: id} : {};
        $.ajax({
            type: "POST",
            url: "${createLink(controller: 'examen', action:'form_ajax')}",
            data: data,
            success: function (msg) {
                var b = bootbox.dialog({
                    id: "dlgCreateEdit",
                    title: title + " Examen",
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


    $(".btnCrear").click(function () {
        createEditRow();
        return false;
    });

</script>

</body>
</html>
