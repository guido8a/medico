<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>

    <style>

    .imag_pq {
        width: 250px;
        margin-right: auto;
        margin-left: auto;
        display: block;
        max-width: 100%;
        height: 250px;
    }
    </style>

</head>

<body style="padding: 20px;">
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

<fieldset class="borde_abajo" style="position: relative;width: 670px;padding-left: 50px;">
    <div class="linea" style="height: 98%;"></div>
    <p class="css-vertical-text">Archivo</p>
    <g:uploadForm action="uploadFileExamen" method="post" name="frmUpload" enctype="multipart/form-data"  >
        <g:hiddenField name="id" value="${examen?.id}"/>
        <div class="fieldcontain required">
            <b>Cargar archivo:</b>
            <input type="file" id="file" name="file" class="" multiple accept=".jpeg, .jpg, .png, .pdf"/>

            <div class="btn-group" style="margin-top: 20px;">
                <a href="#" id="submit" class="btn btn-success">
                    <i class="fa fa-save"></i> Guardar
                </a>
            </div>
        </div>
    </g:uploadForm>
</fieldset>

<g:if test="${examen?.path}">
    <div class="alert alert-info" style="margin-top: 10px">
        Documento actualmente cargado:   <strong style="font-size: 14px">${examen?.path}</strong>
    </div>
    <div class="btn-group" style="margin-top: 0px; margin-left: 52px">
        <a href="#" class="btn btn-danger btn-delete">
            <i class="fa fa-trash"></i> Borrar
        </a>
    </div>

    <g:if test="${examen?.path?.split("\\.")[1] != 'pdf'}">
        <img src="${createLink(controller: 'historial', action: 'getImage', params: [id:examen?.id] )}" class="imag_pq" style="margin-top: 10px"/>
    </g:if>

</g:if>
<g:else>
    <div class="alert alert-warning" style="margin-top: 10px">
        <i class="fa fa-exclamation-triangle fa-2x"></i>
        No existe ningún documento cargado.
    </div>
</g:else>

<script type="text/javascript">

    $("#submit").click(function () {
        // $("#frmUpload").submit();
        return submitFormDocExamen();
    });

    $(".btn-delete").click(function () {
        bootbox.confirm({
            message: "<i class='fa fa-3x fa-exclamation-triangle text-danger'></i> <strong style='font-size: 14px'>  Está seguro que desea borrar el documento asociado al examen? </strong>",
            buttons: {
                confirm: {
                    label: '<i class="fa fa-trash"></i> Borrar',
                    className: 'btn-success'
                },
                cancel: {
                    label: '<i class="fa fa-times"></i> Cancelar',
                    className: 'btn-danger'
                }
            },
            callback: function (result) {
                if(result){
                    $.ajax({
                        type: 'POST',
                        url: '${createLink(controller: 'historial', action: 'borrarDocExamen_ajax')}',
                        data:{
                            id: '${examen?.id}'
                        },
                        success: function (msg) {
                            var parts = msg.split("_");
                            if(parts[0] === 'ok'){
                                log(parts[1],"success");
                                cargarTablaExamenes();
                                cerrarCD();
                            }else{
                                bootbox.alert('<i class="fa fa-exclamation-triangle text-danger fa-3x"></i> ' + '<strong style="font-size: 14px">' + parts[1] + '</strong>');
                            }
                        }
                    });
                }
            }
        });
    });

    function submitFormDocExamen() {
        var $form = $("#frmUpload");
        var formData = new FormData($("#frmUpload")[0]);
        var dialog = cargarLoader("Guardando...");
        $.ajax({
            type    : "POST",
            url     : $form.attr("action"),
            data    : formData,
            processData: false,
            contentType: false,
            success : function (msg) {
                dialog.modal('hide');
                var parts = msg.split("_");
                if(parts[0] === 'ok'){
                    log(parts[1], "success");
                    cargarTablaExamenes();
                    cerrarCD();
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
    }

</script>

</body>
</html>