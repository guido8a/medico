
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <title>Lista de Tipos de Exámenes</title>
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
            <i class="fa fa-clipboard-list"></i> Nuevo Tipo
        </g:link>
    </div>
</div>


<div style="overflow: hidden">
    <fieldset class="borde" style="border-radius: 4px; margin-bottom: 10px">
        <div class="row-fluid" style="margin-left: 10px">
            <span class="grupo">
                <span class="col-md-1">
                    <label class="control-label text-info">Grupo Examen</label>
                </span>
                <span class="col-md-3">
                    <g:select name="grupo" from="${medico.GrupoExamen.list([sort: 'descripcion'])}" class="form-control" optionKey="id" optionValue="descripcion" noSelection="[null: 'TODOS']" />
                </span>
                <span class="col-md-1">
                    <label class="control-label text-info">Criterio</label>
                </span>
                <span class="col-md-4">
                    <g:textField name="criterio" id="criterio" class="form-control"/>
                </span>
            </span>
            <div class="col-md-1">
                <button class="btn btn-info" id="btnBuscarTipoExamen"><i class="fa fa-search"></i>Buscar</button>
            </div>
            <div class="col-md-1">
                <button class="btn btn-warning" id="btnLimpiar" title="Limpiar Búsqueda"><i class="fa fa-eraser"></i>Limpiar</button>
            </div>
        </div>
    </fieldset>

    <fieldset class="borde" style="border-radius: 4px">
        <div id="divTablaExamenes" >
        </div>
    </fieldset>
</div>

<script type="text/javascript">
    var id = null;

    $("#grupo").change(function () {
        cargarTablaTipoExamenes();
    });

    $("#btnLimpiar").click(function  () {
        $("#criterio").val('');
        cargarTablaTipoExamenes();
    });

    $("#btnBuscarTipoExamen").click(function () {
        cargarTablaTipoExamenes();
    });

    $("#criterio").keydown(function (ev) {
        if (ev.keyCode === 13) {
            cargarTablaTipoExamenes();
            return false;
        }
        return true;
    });

    cargarTablaTipoExamenes();

    function cargarTablaTipoExamenes(){
        var d = cargarLoader("Cargando...");
        var grupo = $("#grupo option:selected").val();
        var criterio = $("#criterio").val();
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'tipoExamen', action: 'tablaTipoExamen_ajax')}',
            data:{
                grupo: grupo,
                criterio: criterio
            },
            success: function (msg){
                d.modal("hide");
                $("#divTablaExamenes").html(msg)
            }
        })
    }

    function submitForm() {
        var $form = $("#frmExamen");
        if ($form.valid()) {
            $.ajax({
                type    : "POST",
                url     : '${createLink(controller: 'tipoExamen', action:'save_ajax')}',
                data    : $form.serialize(),
                success : function (msg) {
                    var parts = msg.split("_");
                    if(parts[0] === 'ok'){
                        log(parts[1], "success");
                        cargarTablaTipoExamenes();
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
            message : "<i class='fa fa-trash fa-2x pull-left text-danger text-shadow'></i><p style='font-weight: bold; font-size: 14px'> ¿Está seguro que desea eliminar el tipo seleccionado?.</p>",
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
                            url     : '${createLink(controller: 'tipoExamen', action:'delete_ajax')}',
                            data    : {
                                id : itemId
                            },
                            success : function (msg) {
                                var parts = msg.split("_");
                                if(parts[0] === 'ok'){
                                    log(parts[1],"success");
                                    cargarTablaTipoExamenes();
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
            url     : "${createLink(controller: 'tipoExamen', action:'form_ajax')}",
            data    : data,
            success : function (msg) {
                var b = bootbox.dialog({
                    id      : "dlgCreateEdit",
                    title   : title + " Examen",
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

</script>

</body>
</html>
