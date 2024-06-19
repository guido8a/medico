<h4>Comentario Final</h4>
<div class="" style="width: 99.7%; overflow-y: auto;float: right; margin-top: 10px; margin-bottom: 20px">
    <div style="width: 3%; float: left; margin-right: 5px">
        <a href="#" class="btn btn-info col-md-12" role="alert" id="btnEditarComentario" title="Editar comentario final de la cita médica">
            <i class="fas fa-edit"></i>
        </a>
    </div>
    <div style="width:96%; float: left">
        <table class="table-bordered table-condensed " style="width: 100%">
            <tbody>
            <tr style="font-size: 16px">
            <td style="width: 80%; background-color:#b7d6a9">
                <g:if test="${cita?.comentarioFinal}">
                    ${cita?.comentarioFinal}
                </g:if>
                <g:else>
                    <div class="alert alert-success" style="margin-top: 0px; text-align: center; font-size: 14px; font-weight: bold"><i class="fa fa-exclamation-triangle fa-2x text-info"></i> Sin comentario final</div>
                </g:else>
            </td>
            </tr>
            </tbody>
        </table>
    </div>
</div>

<script type="text/javascript">

    $("#btnEditarComentario").click(function () {
        createEditRowComentario();
    });

    function createEditRowComentario() {
        $.ajax({
            type    : "POST",
            url: "${createLink(controller: 'historial',  action:'formComentario_ajax')}",
            data    : {
                id: '${cita?.id}'
            },
            success : function (msg) {
                cf = bootbox.dialog({
                    id      : "dlgCreateEditComentario",
                    title   : "Comentario Final",
                    class: "modal-lg",
                    message : msg,
                    buttons : {
                        guardar  : {
                            id        : "btnSave",
                            label     : "<i class='fa fa-save'></i> Guardar",
                            className : "btn-success",
                            callback  : function () {
                                return submitFormComentario();
                            } //callback
                        } //guardar
                    } //buttons
                }); //dialog
            } //success
        }); //ajax
    } //createEdit

    function submitFormComentario() {
        var $form = $("#frmComentario");
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
                        cargarComentario('${cita?.id}');
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

</script>