

<div class="tituloTree">
    Exámenes ${tipo == '1' ? ' de Imagen ' : ''} del  paciente: <span style="font-weight: bold; font-style: italic; font-size: 12px">${historial?.paciente?.apellido + " " + historial?.paciente?.nombre}</span>
</div>

<g:if test="${flash.message}">
    <div class="row">
        <div class="span12">
            <div class="alert ${flash.clase ?: 'alert-info'}" role="status">
                <a class="close" data-dismiss="alert" href="#">×</a>
                ${flash.message}
            </div>
        </div>
    </div>
</g:if>

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
        <div id="divTablaExamenes" >
        </div>
    </fieldset>
</div>


<script type="text/javascript">

    var fe;

    $(".btn-new").click(function () {
        createEditRow();
    }); //click btn new

    cargarTablaExamenes();

    function cargarTablaExamenes(){
        var d = cargarLoader("Cargando...");
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'historial', action: 'tablaExamenes_ajax')}',
            data:{
                id: '${historial?.id}',
                tipo: '${tipo}'
            },
            success: function (msg){
                d.modal("hide");
                $("#divTablaExamenes").html(msg)
            }
        })
    }

    function createEditRow(id) {
        var title = id ? "Editar " : "Crear ";
        var data = {
            cita : "${historial.id}",
            id: id
        };
        $.ajax({
            type    : "POST",
            url: "${createLink(action:'formExamenes_ajax')}",
            data    : data,
            success : function (msg) {
                fe = bootbox.dialog({
                    id      : "dlgCreateEditExamen",
                    title   : title + " Examen",
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
                                return submitFormExamen();
                            } //callback
                        } //guardar
                    } //buttons
                }); //dialog
            } //success
        }); //ajax
    } //createEdit

    function submitFormExamen() {
        var $form = $("#frmExamen");
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
                        cerrarDialogoCrearExamen();
                        cargarTablaExamenes();
                        cargarUltimaCita('${historial?.id}');
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
            return false;
        } else {
            return false;
        }


    }

    function deleteRow(itemId) {
        bootbox.dialog({
            title   : "Alerta",
            message : "<i class='fa fa-trash fa-2x pull-left text-danger text-shadow'></i><p style='font-weight: bold'> Está seguro que desea eliminar este examen? Si posee un archivo asociado también será eliminado.</p>",
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
                            url     : '${createLink(controller: 'historial', action: 'borrarExamen_ajax')}',
                            data    : {
                                id : itemId
                            },
                            success : function (msg) {
                                v.modal("hide");
                                var parts = msg.split("_");
                                if(parts[0] === 'ok'){
                                    log(parts[1],"success");
                                    cargarTablaExamenes();
                                    cargarUltimaCita('${historial?.id}');
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

    function cerrarDialogoCrearExamen () {
        fe.modal("hide");
    }


</script>

