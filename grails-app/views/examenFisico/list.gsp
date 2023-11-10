<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>

</head>

<body>

<div class="tituloTree">
    Exámenes físcos del  paciente: <span style="font-weight: bold; font-style: italic; font-size: 12px">${paciente?.apellido + " " + paciente?.nombre}</span>
</div>


<div class="row" style="margin-bottom: 10px">
    <div class="col-md-2 btn-group" role="navigation">
        <a href="#" class="btn btn-success btn-new">
            <i class="fa fa-file"></i>
            Nuevo Examen
        </a>
    </div>
</div>

<div style="overflow: hidden">
    <fieldset class="borde" style="border-radius: 4px">
        <div id="divTablaExamenesFisicos" >
        </div>
    </fieldset>
</div>


<script type="text/javascript">

    var cf;

    $(".btn-new").click(function () {
        createEditRow();
    }); //click btn new

    cargarTablaExamenesFisicos();

    function cargarTablaExamenesFisicos(){
        var d = cargarLoader("Cargando...");
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'examenFisico', action: 'tablaExamenesFisicos_ajax')}',
            data:{
                id: '${paciente?.id}'
            },
            success: function (msg){
                d.modal("hide");
                $("#divTablaExamenesFisicos").html(msg)
            }
        })
    }

    function createEditRow(id) {
        var title = id ? "Editar " : "Crear ";
        var data = {
            id: id,
            paciente: '${paciente?.id}'
        };
        $.ajax({
            type    : "POST",
            url: "${createLink(action:'form_ajax')}",
            data    : data,
            success : function (msg) {
                cf = bootbox.dialog({
                    id      : "dlgCreateEditExamenFisico",
                    title   : title + " Examen Físico",
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
                                return submitFormExamenFisico();
                            } //callback
                        } //guardar
                    } //buttons
                }); //dialog
            } //success
        }); //ajax
    } //createEdit

    function submitFormExamenFisico() {
        var $form = $("#frmExamenFisico");
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
                        cargarTablaExamenesFisicos();
                    }else{
                        if(parts[0] === 'err'){
                            bootbox.alert('<i class="fa fa-exclamation-triangle text-danger fa-3x"></i> ' + '<strong style="font-size: 14px">' + parts[1] + '</strong>');
                            return false;
                        }else{
                            bootbox.alert('<i class="fa fa-exclamation-triangle text-danger fa-3x"></i> ' + '<strong style="font-size: 14px">' + parts[1] + '</strong>');
                            return false;
                        }
                    }
                }
            });
        } else {
            return false;
        }
    }

    function deleteRowEF(itemId) {
        bootbox.dialog({
            title   : "Alerta",
            message : "<i class='fa fa-trash fa-2x pull-left text-danger text-shadow'></i><p style='font-weight: bold; font-size: 14px'> Está seguro que desea eliminar este examen?.</p>",
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
                            url     : '${createLink(controller: 'examenFisico', action: 'borrarExamenFisico_ajax')}',
                            data    : {
                                id : itemId
                            },
                            success : function (msg) {
                                v.modal("hide");
                                var parts = msg.split("_");
                                if(parts[0] === 'ok'){
                                    log(parts[1],"success");
                                    cargarTablaExamenesFisicos();
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

</script>

</body>
</html>
