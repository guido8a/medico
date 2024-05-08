<!doctype html>
<html>
<head>
    <meta name="layout" content="main">
    <title>
        Biblioteca de ${usuario.empresa.nombre}
    </title>
</head>
<body>

<div class="row" style="margin-bottom: 20px">
    <div class="col-md-3 btn-group">
        <a href="#" class="btn btn-success btnNuevoDocumento">
            <i class="fa fa-file"></i>
            Nuevo Documento
        </a>
    </div>
    <div class="col-md-9"></div>
</div>

<div style="overflow: hidden">
    <fieldset class="borde" style="border-radius: 4px; margin-bottom: 10px">
        <div class="row-fluid" style="margin-left: 10px">
            <span class="grupo">
                <span class="col-md-1">
                    <label class="control-label text-info">Criterio</label>
                </span>
                <span class="col-md-4">
                    <g:textField name="criterio" id="criterio" class="form-control"/>
                </span>
            </span>
            <div class="col-md-1">
                <button class="btn btn-info" id="btnBuscarBiblioteca"><i class="fa fa-search"></i>Buscar</button>
            </div>
            <div class="col-md-1">
                <button class="btn btn-warning" id="btnLimpiar" title="Limpiar Búsqueda"><i class="fa fa-eraser"></i></button>
            </div>
        </div>
    </fieldset>

    <fieldset class="borde" style="border-radius: 4px">
        <div id="divTablaBiblioteca" >
        </div>
    </fieldset>
</div>


<script type="text/javascript">
    var di;


    $(".btnNuevoDocumento").click(function () {
        createEditRow();
    });

    $(".btnImprimir").click(function () {
        location.href="${createLink(controller: 'documento', action: 'imprimir')}";
    });

    $("#btnLimpiar").click(function  () {
        $("#criterio").val('');
        cargarTablaBiblioteca();
    });

    $("#btnBuscarBiblioteca").click(function () {
        cargarTablaBiblioteca();
    });

    $("#criterio").keydown(function (ev) {
        if (ev.keyCode === 13) {
            cargarTablaBiblioteca();
            return false;
        }
        return true;
    });

    cargarTablaBiblioteca();

    function cargarTablaBiblioteca() {
        var d = cargarLoader("Cargando...");
        var criterio = $("#criterio").val();
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'documento', action: 'tablaBiblioteca_ajax')}',
            data:{
                criterio: criterio,
            },
            success: function (msg){
                d.modal("hide");
                $("#divTablaBiblioteca").html(msg)
            }
        })
    }

    function createEditRow(id) {
        var title = id ? "Editar " : "Crear ";
        var data = id ? {id : id}: {};

        $.ajax({
            type    : "POST",
            url: "${createLink(action:'form_ajax')}",
            data    : data,
            success : function (msg) {
                var b = bootbox.dialog({
                    id      : "dlgCreateEditDocumento",
                    title   : title + " Documento",
                    class: "modal-lg",
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
                                return submitFormDocumento();
                            } //callback
                        } //guardar
                    } //buttons
                }); //dialog
            } //success
        }); //ajax
    } //createEdit

    function submitFormDocumento() {
        var $form = $("#frmDocumento");
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
                        cargarTablaBiblioteca();
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
            message : "<i class='fa fa-trash fa-2x pull-left text-danger text-shadow'></i><p style='font-weight: bold'> Está seguro que desea eliminar este documento? Esta acción no se puede deshacer.</p>",
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
                            url     : '${createLink(controller: 'documento',  action:'borrarDocumento_ajax')}',
                            data    : {
                                id : itemId
                            },
                            success : function (msg) {
                                v.modal("hide");
                                var parts = msg.split("_");
                                if(parts[0] === 'ok'){
                                    log(parts[1],"success");
                                    cargarTablaBiblioteca();
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

    function cargarImagenePaciente(id) {
        %{--$.ajax({--}%
        %{--    type    : "POST",--}%
        %{--    url     : "${createLink(controller: 'empresa', action:'logoEmpresa_ajax')}",--}%
        %{--    data    : {--}%
        %{--        id:id--}%
        %{--    },--}%
        %{--    success : function (msg) {--}%
        %{--        di = bootbox.dialog({--}%
        %{--            id      : "dlgImas",--}%
        %{--            title   : "Logo de la empresa",--}%
        %{--            message : msg,--}%
        %{--            buttons : {--}%
        %{--                cancelar : {--}%
        %{--                    label     : "<i class='fa fa-times'></i> Cerrar",--}%
        %{--                    className : "btn-gris",--}%
        %{--                    callback  : function () {--}%

        %{--                    }--}%
        %{--                }--}%
        %{--            } //buttons--}%
        %{--        }); //dialog--}%
        %{--    } //success--}%
        %{--}); //ajax--}%
    } //createEdit

    function cerrarDialogoImagen () {
        di.modal("hide");
    }


</script>

</body>
</html>