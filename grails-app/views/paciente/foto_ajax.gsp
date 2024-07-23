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
    <g:uploadForm action="uploadFile" method="post" name="frmUpload" enctype="multipart/form-data"  >
        <g:hiddenField name="id" value="${paciente?.id}"/>
        <div class="fieldcontain required">
            <b>Cargar archivo:</b>
            <input type="file" id="file" name="file" class="" multiple accept=".jpeg, .jpg, .png"/>

            <div class="btn-group" style="margin-top: 20px;">
                <a href="#" id="submit" class="btn btn-success">
                    <i class="fa fa-save"></i> Guardar
                </a>
            </div>

            <g:if test="${paciente?.foto}">
                <div class="btn-group" style="margin-top: 20px;">
                    <a href="#" class="btn btn-danger btn-delete">
                        <i class="fa fa-trash"></i> Borrar
                    </a>
                </div>
            </g:if>
        </div>
    </g:uploadForm>
</fieldset>

<g:if test="${paciente?.foto}">
    <p class="css-vertical-text">
        Foto
    </p>
    <div class="linea" style="height: 40%;"></div>
    <img src="${createLink(controller: 'paciente', action: 'getImage', params: [id:paciente?.id] )}" class="imag_pq" style="margin-top: 10px"/>
</g:if>
<g:else>
    <div class="alert alert-warning" style="margin-top: 10px">
        <i class="fa fa-exclamation-triangle fa-2x"></i>
        No existe una foto cargada.
    </div>
</g:else>

<script type="text/javascript">

    $("#submit").click(function () {
        // $("#frmUpload").submit();
        return submitFormCitasAnteriores();
    });

    function submitFormCitasAnteriores(){
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
                    cerrarDialogoImagen();
                }else{
                    bootbox.alert('<i class="fa fa-exclamation-triangle text-danger fa-3x"></i> ' + '<strong style="font-size: 14px">' + parts[1] + '</strong>');
                    return false;
                }
            }
        });
    }

    $(".btn-delete").click(function () {
        bootbox.confirm({
            message: "<i class='fa fa-3x fa-exclamation-triangle text-danger'></i> <strong style='font-size: 14px'>  Está seguro que desea borrar la imagen? </strong>",
            buttons: {
                confirm: {
                    label: 'Borrar',
                    className: 'btn-success'
                },
                cancel: {
                    label: 'Cancelar',
                    className: 'btn-danger'
                }
            },
            callback: function (result) {
                if(result){
                    $.ajax({
                        type: 'POST',
                        url: '${createLink(controller: 'paciente', action: 'borrarFoto_ajax')}',
                        data:{
                            id: '${paciente?.id}'
                        },
                        success: function (msg) {
                            var parts = msg.split("_");
                            if(parts[0] === 'ok'){
                                log("Imagen borrada correctamente","success");
                                cerrarDialogoImagen();
                            }else{
                                if(parts[0] === 'er'){
                                    bootbox.alert("<i class='fa fa-exclamation-triangle fa-2x text-danger'></i>" + parts[1])
                                }else{
                                    log("Error al borrar la imagen","error")
                                }

                            }
                        }
                    });
                }
            }
        });
    });


</script>

</body>
</html>