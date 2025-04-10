<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <title>Lista de Tipologías</title>
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
        <a href="#" class="btn btn-success btnNuevoSubTema">
            <i class="fa fa-file"></i>
            Nueva tipología
        </a>
    </div>
</div>

<div style="overflow: hidden">
    <fieldset class="borde" style="border-radius: 4px; margin-bottom: 10px">
        <div class="row-fluid">
            <span class="col-md-1">
                <label class="control-label text-info">Tema</label>
            </span>
            <span class="col-md-3">
                <g:select name="tema" from="${medico.Tema.list([sort: 'nombre'])}" optionValue="nombre" optionKey="id" class="form-control" noSelection="[null : 'Todos']"/>
            </span>
            <span class="col-md-1">
                <label class="control-label text-info">Criterio</label>
            </span>
            <span class="col-md-4">
                <g:textField name="criterio" id="criterio" class="form-control"/>
            </span>
            <div class="col-md-1">
                <button class="btn btn-info" id="btnBuscarSubTema"><i class="fa fa-search"></i> Buscar</button>
            </div>
            <div class="col-md-1">
                <button class="btn btn-warning" id="btnLimpiar" title="Limpiar Búsqueda"><i class="fa fa-eraser"></i> Limpiar</button>
            </div>
        </div>
    </fieldset>

    <fieldset class="borde" style="border-radius: 4px">
        <div id="divTablaSubTema" >
        </div>
    </fieldset>
</div>

<script type="text/javascript">
    var di;

    $(".btnNuevoSubTema").click(function () {
        createEditRow();
    });

    $("#btnLimpiar").click(function  () {
        $("#criterio").val('');
        cargarTablaSubTema();
    });

    $("#btnBuscarSubTema").click(function () {
        cargarTablaSubTema();
    });

    $("#criterio").keydown(function (ev) {
        if (ev.keyCode === 13) {
            cargarTablaSubTema();
            return false;
        }
        return true;
    });

    cargarTablaSubTema();

    function cargarTablaSubTema() {
        var d = cargarLoader("Cargando...");
        var tema = $("#tema option:selected").val();
        var criterio = $("#criterio").val();
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'subtema', action: 'tablaSubtema_ajax')}',
            data:{
                tema: tema,
                criterio: criterio
            },
            success: function (msg){
                d.modal("hide");
                $("#divTablaSubTema").html(msg)
            }
        })
    }

    function createEditRow(id) {
        var title = id ? "Editar " : "Crear ";
        var data = id ? {id : id}: {};

        $.ajax({
            type    : "POST",
            url: "${createLink(controller: 'subtema',  action:'form_ajax')}",
            data    : data,
            success : function (msg) {
                var b = bootbox.dialog({
                    id      : "dlgCreateEdit",
                    title   : title + " tipología",
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
                                return submitFormSubTema();
                            } //callback
                        } //guardar
                    } //buttons
                }); //dialog
            } //success
        }); //ajax
    } //createEdit

    function submitFormSubTema() {
        var $form = $("#frmSubtema");
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
                        cargarTablaSubTema();
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
            message : "<i class='fa fa-trash fa-2x pull-left text-danger text-shadow'></i><p style='font-weight: bold'> Está seguro que desea eliminar esta tipología? Esta acción no se puede deshacer.</p>",
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
                            url     : '${createLink(action:'borrarSubTema_ajax')}',
                            data    : {
                                id : itemId
                            },
                            success : function (msg) {
                                v.modal("hide");
                                var parts = msg.split("_");
                                if(parts[0] === 'ok'){
                                    log(parts[1],"success");
                                    cargarTablaSubTema();
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
