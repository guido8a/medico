
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <title>Lista de Exámenes</title>
</head>
<body>

<!-- botones -->
<div class="btn-toolbar toolbar" style="margin-bottom: 15px">
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
</div>

<table class="table table-condensed table-bordered table-striped">
    <thead>
    <tr>
        <th>Tipo</th>
        <th>Descripción</th>
        <th>Acciones</th>
    </tr>
    </thead>
    <tbody>
    <g:each in="${examenes}" status="i" var="examen">
        <tr data-id="${examen.id}">
            <td>${examen?.tipo}</td>
            <td>${examen?.descripcion}</td>
            <td style="width: 10%; text-align: center">
                <a href="#" class="btn btn-xs btn-success btnEditarExamen" data-id="${examen?.id}" title="Editar">
                    <i class="fas fa-edit"></i>
                </a>
                <a href="#" class="btn btn-xs btn-danger btnEliminarExamen" data-id="${examen?.id}" title="Eliminar">
                    <i class="fas fa-trash"></i>
                </a>
            </td>
        </tr>
    </g:each>
    </tbody>
</table>


<script type="text/javascript">
    var id = null;

    function submitForm() {
        var $form = $("#frmExamen");
        if ($form.valid()) {
            $.ajax({
                type    : "POST",
                url     : '${createLink(controller: 'examen', action:'save_ajax')}',
                data    : $form.serialize(),
                success : function (msg) {
                    var parts = msg.split("_");
                    if(parts[0] === 'ok'){
                        log(parts[1], "success");
                        setTimeout(function () {
                            location.reload()
                        }, 800);
                    }else{
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
            title   : "Alerta",
            message : "<i class='fa fa-trash fa-2x pull-left text-danger text-shadow'></i><p>¿Está seguro que desea eliminar el examen seleccionado? Esta acción no se puede deshacer.</p>",
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
                            url     : '${createLink(controller: 'examen', action:'delete_ajax')}',
                            data    : {
                                id : itemId
                            },
                            success : function (msg) {
                                var parts = msg.split("_");
                                if(parts[0] === 'ok'){
                                    log(parts[1],"success");
                                    setTimeout(function () {
                                        location.reload()
                                    }, 800);
                                }else{
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
        var data = id ? { id: id } : {};
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'examen', action:'form_ajax')}",
            data    : data,
            success : function (msg) {
                var b = bootbox.dialog({
                    id      : "dlgCreateEdit",
                    title   : title + " Tema",
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

    $(".btnEditarExamen").click(function () {
        var id = $(this).data("id");
        createEditRow(id);
    });

    $(".btnEliminarExamen").click(function () {
        var id = $(this).data("id");
        deleteRow(id);
    });


</script>

</body>
</html>
