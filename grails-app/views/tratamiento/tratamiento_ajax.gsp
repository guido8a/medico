<div class="tituloTree">
    Tratamiento del  paciente: <span style="font-weight: bold; font-style: italic; font-size: 12px">${historial?.paciente?.apellido + " " + historial?.paciente?.nombre}</span>
</div>


<div class="row" style="margin-bottom: 10px">
    <div class="col-md-2 btn-group" role="navigation">
        <a href="#" class="btn btn-success btn-new">
            <i class="fa fa-file"></i>
            Agregar tratamiento
        </a>
    </div>
</div>

<div style="overflow: hidden">
    <fieldset class="borde" style="border-radius: 4px">
        <div id="divTablaTratamiento" >
        </div>
    </fieldset>
</div>

<div class="row izquierda">
    <div class="col-md-12 input-group">
        <label for="tratamiento" class="col-md-1 control-label text-info">
            Medidas generales
        </label>
        <span class="col-md-11">
            <g:textArea name="tratamiento" maxlength="511" class="form-control" style="resize: none; height: 100px;"  value="${historial?.tratamiento}"/>
        </span>
    </div>
</div>

<script type="text/javascript">

    $(".btn-new").click(function () {
        createEditRow();
    }); //click btn new

    cargarTablaTratamientos();

    function cargarTablaTratamientos(){
        var d = cargarLoader("Cargando...");
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'tratamiento', action: 'tablaTratamiento_ajax')}',
            data:{
                id: '${historial?.id}'
            },
            success: function (msg){
                d.modal("hide");
                $("#divTablaTratamiento").html(msg)
            }
        })
    }

    function createEditRow(id) {
        var title = id ? "Editar " : "Nuevo ";
        var data = {
            cita : "${historial.id}",
            id: id
        };
        $.ajax({
            type    : "POST",
            url: "${createLink(action:'form_ajax')}",
            data    : data,
            success : function (msg) {
                var b = bootbox.dialog({
                    id      : "dlgCreateEditTratamiento",
                    title   : title + " Tratamiento",
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
                                return submitFormTratamiento();
                            } //callback
                        } //guardar
                    } //buttons
                }); //dialog
            } //success
        }); //ajax
    } //createEdit

    function submitFormTratamiento() {
        var $form = $("#frmTratamiento");
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
                        cargarTablaTratamientos();
                        %{--cargarUltimaCita('${historial?.id}');--}%
                        cargarComboCita('${historial?.id}');
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
            message : "<i class='fa fa-trash fa-2x pull-left text-danger text-shadow'></i><p style='font-weight: bold; font-size: 14px'> Está seguro que desea eliminar este tratamiento?.</p>",
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
                            url     : '${createLink(controller: 'tratamiento', action: 'borrarTratamiento_ajax')}',
                            data    : {
                                id : itemId
                            },
                            success : function (msg) {
                                v.modal("hide");
                                var parts = msg.split("_");
                                if(parts[0] === 'ok'){
                                    log(parts[1],"success");
                                    cargarTablaTratamientos();
                                    cargarComboCita('${historial?.id}');
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

